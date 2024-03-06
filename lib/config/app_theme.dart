import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() => ThemeMode.system;

  void toggle([ThemeMode? mode]) => state = mode ?? (state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
}

class AppColors {
  static const lightBackground = Color(0xfff2f2f2);
  static const darkBackground = Colors.black;
  static const lightTertiary = Colors.lightBlueAccent;
  static const darkTertiary = Colors.blue;
  static const lightOutline = Color(0xFF666666);
  static const darkOutline = Color(0xfff2f2f2);
}

final _appTheme = ThemeData(
  fontFamily: "DidactGothic",
);

final appThemeLight = _appTheme.copyWith(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: AppColors.lightBackground,
    tertiary: AppColors.lightTertiary,
    outline: AppColors.lightOutline,
  ),
);
final appThemeDark = _appTheme.copyWith(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkBackground,
    tertiary: AppColors.darkTertiary,
    outline: AppColors.darkOutline,
  ),
);
