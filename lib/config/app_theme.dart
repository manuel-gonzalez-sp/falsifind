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
  static const lightBackground = Color(0xfff2f2f2);
  static const darkBackground = Colors.black;

  static const lightTertiary = Colors.lightBlueAccent;
  static const darkTertiary = Colors.blue;

  static const lightOutline = Color(0xFF666666);
  static const darkOutline = Color(0xfff2f2f2);

  static const secondary = Color(0xff666666);
  static const onSecondary = Colors.white;

  static const danger = Color(0xffcc254c);
  static const onDanger = Colors.white;

  static const success = Color(0xff32b85e);
  static const onSuccess = Colors.white;

  static const accent = Colors.white;
}

final _appTheme = ThemeData(
  fontFamily: "DidactGothic",
  scaffoldBackgroundColor: AppColors.lightBackground,
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
    surface: AppColors.lightBackground,
  ),
);
