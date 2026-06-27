import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const BoxShadow card = BoxShadow(
    color: Color(0x22000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  static const List<BoxShadow> cardList = [card];
}
