import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/theme/nexus_theme.dart';
import 'app/router/app_router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'core/services/offline_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:ui';
import 'core/services/local_ai_service.dart';
import 'core/services/push_notification_service.dart';
import 'core/services/freerasp_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize FreeRASP Security
  try {
    FreeRaspService.initialize();
  } catch (e) {
    debugPrint('FreeRASP initialization failed: $e');
  }
  
  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize ProviderContainer to access providers before runApp
  final container = ProviderContainer();
  
  // Initialize OfflineService (Isar)
  await container.read(offlineServiceProvider).initialize();
  
  // Initialize LocalAIService (Gemini)
  await container.read(localAIServiceProvider).initialize();

  // Initialize Firebase (Try/Catch as config might be missing)
  try {
    await Firebase.initializeApp();
    
    // Crashlytics setup
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await PushNotificationService().initialize();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const NexusApp(),
    ),
  );
}

class NexusApp extends ConsumerWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Nexus - Consciencia Digital',
      debugShowCheckedModeBanner: false,
      theme: NexusTheme.darkTheme,
      routerConfig: router,
    );
  }
}
