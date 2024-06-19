import 'package:falsifind/layouts/home_layout.dart';
import 'package:falsifind/screens/info/info_screen.dart';
import 'package:falsifind/screens/news_details/news_details_screen.dart';
import 'package:falsifind/screens/news_history/news_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/news_history',
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return HomeLayout(child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/news_history',
          builder: (BuildContext context, GoRouterState state) {
            return const NewsHistoryScreen();
          },
        ),
        GoRoute(
          path: '/news_details',
          builder: (BuildContext context, GoRouterState state) {
            final url = state.extra as String?;
            return NewsDetailsScreen(url);
          },
        ),
        GoRoute(
          path: '/info',
          builder: (BuildContext context, GoRouterState state) {
            return const InfoScreen();
          },
        ),
      ],
    ),
  ],
);
