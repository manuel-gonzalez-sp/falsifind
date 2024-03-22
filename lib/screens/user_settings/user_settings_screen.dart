import 'package:falsifind/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserSettingsScreen extends HookConsumerWidget {
  const UserSettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Container(
        alignment: Alignment.center,
        child: Text('Ajustes', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
