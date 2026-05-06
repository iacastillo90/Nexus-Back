import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/widgets.dart';

class VoiceCloningScreen extends ConsumerStatefulWidget {
  const VoiceCloningScreen({super.key});

  @override
  ConsumerState<VoiceCloningScreen> createState() => _VoiceCloningScreenState();
}

class _VoiceCloningScreenState extends ConsumerState<VoiceCloningScreen> {
  late final Record _audioRecorder;
  late final AudioPlayer _audioPlayer;
  
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordingPath;
  int _recordDuration = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _audioRecorder = Record();
    _audioPlayer = AudioPlayer();
    
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getTemporaryDirectory();
        final path = '${directory.path}/voice_clone_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(path: path, encoder: AudioEncoder.aacLc);

        setState(() {
          _isRecording = true;
          _recordDuration = 0;
        });

        _startTimer();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Microphone permission required')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      _timer?.cancel();
      
      setState(() {
        _isRecording = false;
        _recordingPath = path;
      });
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  Future<void> _playRecording() async {
    try {
      if (_recordingPath != null) {
        Source urlSource = UrlSource(_recordingPath!);
        await _audioPlayer.play(urlSource);
        setState(() {
          _isPlaying = true;
        });
      }
    } catch (e) {
      debugPrint('Error playing recording: $e');
    }
  }

  Future<void> _stopPlayback() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      debugPrint('Error stopping playback: $e');
    }
  }

  void _deleteRecording() {
    setState(() {
      _recordingPath = null;
      _isPlaying = false;
    });
    // Optionally delete file from storage
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordDuration++;
      });
    });
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Voice Cloning'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Instructions
            NexusGlassContainer(
              child: Column(
                children: [
                  const Icon(Icons.record_voice_over,
                      size: 48, color: AppColors.nexusBlue),
                  const SizedBox(height: AppDimensions.space16),
                  Text(
                    'Clone Your Voice',
                    style: AppTypography.headlineSmall
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: AppDimensions.space8),
                  Text(
                    'Read the following text to create your digital voice twin.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.space24),

            // Script Card
            Expanded(
              child: NexusCard(
                padding: const EdgeInsets.all(AppDimensions.space24),
                child: Center(
                  child: Text(
                    '"The digital realm is an extension of our consciousness. Through the Nexus, we connect, we create, and we evolve. My voice is now part of the collective dream."',
                    style: AppTypography.headlineSmall.copyWith(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.space24),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_recordingPath != null) ...[
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                    iconSize: 48,
                    color: AppColors.nexusBlue,
                    onPressed: _isPlaying ? _stopPlayback : _playRecording,
                  ),
                  const SizedBox(width: 32),
                ],
                GestureDetector(
                  onTap: () {
                    if (_isRecording) {
                      _stopRecording();
                    } else {
                      _startRecording();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRecording
                          ? AppColors.errorFlare.withValues(alpha: 0.2)
                          : AppColors.nexusBlue.withValues(alpha: 0.2),
                      border: Border.all(
                        color: _isRecording
                            ? AppColors.errorFlare
                            : AppColors.nexusBlue,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_isRecording
                                  ? AppColors.errorFlare
                                  : AppColors.nexusBlue)
                              .withValues(alpha: 0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (_recordingPath != null) ...[
                  const SizedBox(width: 32),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    iconSize: 32,
                    color: AppColors.errorFlare,
                    onPressed: _deleteRecording,
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppDimensions.space16),
            if (_isRecording)
              Text(
                'Recording... ${_formatDuration(_recordDuration)}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.errorFlare),
              ),
            const SizedBox(height: AppDimensions.space32),

            // Submit Button
            NexusButton(
              text: 'Create Voice Clone',
              type: NexusButtonType.primary,
              onPressed: _recordingPath != null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Voice clone processing started...'),
                          backgroundColor: AppColors.nexusBlue,
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
