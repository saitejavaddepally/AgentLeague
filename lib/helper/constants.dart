import 'package:flutter/material.dart';

import '../theme/custom_theme.dart';

final lightShadowColor = Colors.grey.withOpacity(0.5);

const shadow1 = [
  BoxShadow(
      offset: Offset(-6, -6),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0xFF113B5F)),
  BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0xFF031E35)),
];

final shadow2 = [
  BoxShadow(
      offset: const Offset(-6, -6),
      blurRadius: 12,
      spreadRadius: 0,
      color:
          CustomTheme.isDarkTheme ? const Color(0xFF113B5F) : lightShadowColor),
  BoxShadow(
      offset: const Offset(6, 6),
      blurRadius: 12,
      spreadRadius: 0,
      color:
          CustomTheme.isDarkTheme ? const Color(0xFF031E35) : lightShadowColor),
];

const locale = [
  Locale("af"),
  Locale("am"),
  Locale("ar"),
  Locale("az"),
  Locale("be"),
  Locale("bg"),
  Locale("bn"),
  Locale("bs"),
  Locale("ca"),
  Locale("cs"),
  Locale("da"),
  Locale("de"),
  Locale("el"),
  Locale("en"),
  Locale("es"),
  Locale("et"),
  Locale("fa"),
  Locale("fi"),
  Locale("fr"),
  Locale("gl"),
  Locale("ha"),
  Locale("he"),
  Locale("hi"),
  Locale("hr"),
  Locale("hu"),
  Locale("hy"),
  Locale("id"),
  Locale("is"),
  Locale("it"),
  Locale("ja"),
  Locale("ka"),
  Locale("kk"),
  Locale("km"),
  Locale("ko"),
  Locale("ku"),
  Locale("ky"),
  Locale("lt"),
  Locale("lv"),
  Locale("mk"),
  Locale("ml"),
  Locale("mn"),
  Locale("ms"),
  Locale("nb"),
  Locale("nl"),
  Locale("nn"),
  Locale("no"),
  Locale("pl"),
  Locale("ps"),
  Locale("pt"),
  Locale("ro"),
  Locale("ru"),
  Locale("sd"),
  Locale("sk"),
  Locale("sl"),
  Locale("so"),
  Locale("sq"),
  Locale("sr"),
  Locale("sv"),
  Locale("ta"),
  Locale("tg"),
  Locale("th"),
  Locale("tk"),
  Locale("tr"),
  Locale("tt"),
  Locale("uk"),
  Locale("ug"),
  Locale("ur"),
  Locale("uz"),
  Locale("vi"),
  Locale("zh")
];
