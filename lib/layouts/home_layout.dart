import 'package:falsifind/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeLayout extends HookConsumerWidget {
  const HomeLayout(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
          surfaceTintColor: AppColors.background,
          title: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
            Image.asset("assets/logo.png", height: 30),
            const Text('FalsiFind', style: TextStyle(height: 1.3)),
          ]),
        ),
        body: child,
      ),
    );
  }
}
