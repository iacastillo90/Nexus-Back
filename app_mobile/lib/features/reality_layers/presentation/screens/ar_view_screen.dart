import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/utils/ar_utils.dart';
import '../providers/layer_providers.dart';
import '../widgets/ar_post_card.dart';

class ARViewScreen extends ConsumerStatefulWidget {
  const ARViewScreen({super.key});

  @override
  ConsumerState<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends ConsumerState<ARViewScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  double? _heading;
  Position? _currentPosition;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeSensors();
  }

  Future<void> _initializeSensors() async {
    try {
      // 1. Request Permissions
      final cameraStatus = await Permission.camera.request();
      final locationStatus = await Permission.location.request();

      if (cameraStatus.isDenied || locationStatus.isDenied) {
        setState(() => _error = "Camera and Location permissions are required for AR.");
        return;
      }

      // 2. Initialize Camera
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _error = "No camera found.");
        return;
      }

      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      // 3. Initialize Location Stream
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      ).listen((position) {
        if (mounted) setState(() => _currentPosition = position);
      });

      // 4. Initialize Compass Stream
      FlutterCompass.events?.listen((event) {
        if (mounted) setState(() => _heading = event.heading);
      });

      setState(() => _isCameraInitialized = true);
    } catch (e) {
      if (mounted) setState(() => _error = "Error initializing AR: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final geoPostsState = ref.watch(geoPostsProvider);

    if (_error != null) {
      return Scaffold(
        backgroundColor: AppColors.voidBlack,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.errorFlare, size: 48),
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() => _error = null);
                  _initializeSensors();
                },
                child: const Text("Retry"),
              )
            ],
          ),
        ),
      );
    }

    if (!_isCameraInitialized || _heading == null || _currentPosition == null) {
      return const Scaffold(
        backgroundColor: AppColors.voidBlack,
        body: Center(child: CircularProgressIndicator(color: AppColors.nexusBlue)),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // 1. Camera Feed
          SizedBox.expand(
            child: CameraPreview(_cameraController!),
          ),

          // 2. Cyberpunk Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.nexusBlue.withValues(alpha: 0.1),
                  Colors.transparent,
                  AppColors.voidBlack.withValues(alpha: 0.4),
                ],
              ),
            ),
          ),

          // 3. AR Objects
          geoPostsState.when(
            data: (posts) {
              return Stack(
                children: posts.map((post) {
                  // Calculate Bearing
                  double bearing = ARUtils.calculateBearing(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                    post.latitude,
                    post.longitude,
                  );

                  // Check Visibility (FOV ~60 degrees)
                  if (ARUtils.isVisible(_heading!, bearing, 60)) {
                    double xPos = ARUtils.horizontalPosition(_heading!, bearing, 60);
                    
                    // Map -1..1 to screen coordinates
                    final screenWidth = MediaQuery.of(context).size.width;
                    final screenHeight = MediaQuery.of(context).size.height;
                    
                    double screenX = (screenWidth / 2) + (xPos * (screenWidth / 2));
                    
                    // Simple distance scaling (closer = lower on screen, further = higher/smaller)
                    // This is a basic approximation.
                    
                    return Positioned(
                      left: screenX - 80, // Center the 160px card
                      top: screenHeight * 0.4, // Floating at eye level
                      child: ARPostCard(
                        post: post,
                        onTap: () {
                          // Show details
                        },
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }).toList(),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // 4. HUD (Radar & Back Button)
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          
          Positioned(
            bottom: 20,
            left: 20,
            child: _buildRadarWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarWidget() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.voidBlack.withValues(alpha: 0.5),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.nexusBlue.withValues(alpha: 0.5)),
      ),
      child: CustomPaint(
        painter: RadarPainter(heading: _heading ?? 0),
      ),
    );
  }
}

class RadarPainter extends CustomPainter {
  final double heading;

  RadarPainter({required this.heading});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = AppColors.nexusBlue
      ..style = PaintingStyle.stroke;

    // Draw circles
    canvas.drawCircle(center, size.width * 0.3, paint);
    
    // Draw FOV cone based on heading
    // This is a simplified visualization
    final fovPaint = Paint()
      ..color = AppColors.nexusBlue.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
      
    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width, height: size.height),
      -math.pi / 2 - math.pi / 6, // -90 deg - 30 deg
      math.pi / 3, // 60 deg FOV
      true,
      fovPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
