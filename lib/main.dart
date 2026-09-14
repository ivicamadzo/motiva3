import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';
import 'features/audio/core/audio_singleton.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  final startupTime = DateTime.now();

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
