import 'package:flutter/material.dart';
import 'app/app.dart';
import 'features/audio/core/audio_singleton.dart'; // Вметни го синглтонот

void main() async {
  // 1. Обезбеди дека Flutter е подготвен за комуникација со Native делот
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Иницијализирај го аудио системот (AudioService, AudioSession)
  await AudioSingleton.init();

  // 3. Стартувај ја апликацијата
  runApp(const App());
}
