import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseSupport {
  FirebaseSupport._();

  static bool get isEnabled =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseAnalytics get analytics => FirebaseAnalytics.instance;
}
