import 'package:falsifind/layouts/home_layout.dart';
import 'package:falsifind/screens/news_details/news_details_screen.dart';
import 'package:falsifind/screens/news_feed/news_feed_screen.dart';
import 'package:falsifind/screens/news_saved/news_saved.dart';
import 'package:falsifind/screens/user_settings/user_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/news_feed',
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return HomeLayout(child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/news_feed',
          builder: (BuildContext context, GoRouterState state) {
            return const NewsFeedScreen();
          },
        ),
        GoRoute(
          path: '/news_saved',
          builder: (BuildContext context, GoRouterState state) {
            return const NewsSavedScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/news_details/:newsId',
      builder: (BuildContext context, GoRouterState state) {
        final newsId = state.pathParameters['newsId'];
        final content = state.extra.toString();
        return NewsDetailsScreen(newsId!, content: content);
      },
    ),
    GoRoute(
      path: '/user_settings',
      builder: (BuildContext context, GoRouterState state) {
        return const UserSettingsScreen();
      },
    ),
  ],
);
