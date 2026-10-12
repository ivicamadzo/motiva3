import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'app/app.dart';
import 'core/firebase/firebase_support.dart';
import 'features/audio/core/audio_singleton.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  final startupTime = DateTime.now();

  if (FirebaseSupport.isEnabled) {
    await Firebase.initializeApp();

    await FirebaseAppCheck.instance.activate(
      providerAndroid: kDebugMode
          ? const AndroidDebugProvider()
          : const AndroidPlayIntegrityProvider(),
    );

    await FirebaseSupport.analytics.setAnalyticsCollectionEnabled(true);
  }

  await AudioSingleton.init();

  runApp(const App());

  final elapsed = DateTime.now().difference(startupTime);
  const minimumSplashDuration = Duration(milliseconds: 700);
  final remaining = minimumSplashDuration - elapsed;

  if (remaining > Duration.zero) {
    await Future<void>.delayed(remaining);
  }

  FlutterNativeSplash.remove();
}
