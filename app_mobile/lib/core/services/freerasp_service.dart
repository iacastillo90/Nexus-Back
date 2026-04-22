import 'package:freerasp/freerasp.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class FreeRaspService {
  static void initialize() {
    // Configuration for FreeRASP
    final config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: 'com.nexus.app',
        signingCertHashes: ['YOUR_BASE64_ENCODED_CERT_HASH'],
        supportedAlternativeStores: ['com.sec.android.app.samsungapps'],
      ),
      iosConfig: IOSConfig(
        bundleIds: ['com.nexus.app'],
        teamId: 'YOUR_TEAM_ID',
      ),
      watcherMail: 'security@nexus.app',
      isProd: kReleaseMode,
    );

    // Setting up callbacks for threat detection
    final callback = ThreatCallback(
      onAppIntegrity: () => _handleThreat('App Integrity compromised'),
      onObfuscationIssues: () => _handleThreat('Obfuscation issues detected'),
      onDebug: () => _handleThreat('Debugging detected'),
      onDeviceBinding: () => _handleThreat('Device binding failed'),
      onDeviceID: () => _handleThreat('Device ID cloned'),
      onHooks: () => _handleThreat('Hooks detected'),
      onPasscode: () => _handleThreat('No passcode set'),
      onPrivilegedAccess: () => _handleThreat('Privileged access (Root/Jailbreak) detected'),
      onSecureHardwareNotAvailable: () => _handleThreat('Secure hardware not available'),
      onSimulator: () => _handleThreat('Simulator detected'),
      onUnofficialStore: () => _handleThreat('Unofficial store detected'),
    );

    // Initialize Talsec
    Talsec.instance.start(config);
    Talsec.instance.attachListener(callback);
  }

  static void _handleThreat(String threatMessage) {
    debugPrint('🚨 [FreeRASP] Threat Detected: $threatMessage');
    
    if (kReleaseMode) {
      // In production, we force exit the app on critical threats
      // Note: Exit app might not be recommended on iOS due to Apple guidelines,
      // but typically we can navigate to a "Blocked" screen.
      exit(0);
    }
  }
}
