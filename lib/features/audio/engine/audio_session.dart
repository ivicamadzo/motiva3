import 'package:audio_session/audio_session.dart';

class AppAudioSession {
  static Future<void> init() async {
    // 1. Земаме инстанца од аудио сесијата на уредот
    final session = await AudioSession.instance;

    // 2. Ја конфигурираме како 'music' — ова е најдобра поставка за аудио терапија
    // Бидејќи пакетот сам се справува со прекини, нема потреба од друг код
    await session.configure(const AudioSessionConfiguration.music());

    // 3. Ја активираме сесијата за да му дадеме до знаење на системот дека сме спремни
    await session.setActive(true);
  }
}
