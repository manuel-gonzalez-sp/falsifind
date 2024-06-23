import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() => ThemeMode.light;

  void toggle([ThemeMode? mode]) => state = mode ?? (state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
}

class AppColors {
  static const background = Color(0xfff2f2f2);
  static const onBackground = Colors.black;

  static const secondary = Color(0xff1f1f1f);
  static const onSecondary = Colors.white;

  static const outline = Color(0xff666666);
  static const accent = Color(0xff198aa6);
  static const onAccent = Colors.white;

  static const danger = Color(0xffcc254c);
  static const onDanger = Colors.white;

  static const success = Color(0xff32b85e);
  static const onSuccess = Colors.white;
}

final _appTheme = ThemeData(
  fontFamily: "DidactGothic",
  scaffoldBackgroundColor: AppColors.background,
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 22, fontFamily: 'SecularOne'),
    titleMedium: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
    titleSmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, fontFamily: 'SecularOne'),
    labelLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    labelSmall: TextStyle(fontSize: 12),
  ),
);

final appThemeLight = _appTheme.copyWith(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: AppColors.background,
  ),
);
