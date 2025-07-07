import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'package:freeze/core/routing/transitions.dart';
import 'pages/login_page.dart';

List<GoRoute> get authRoutes => <GoRoute>[
  GoRoute(
    path: Routes.login,
    pageBuilder: (_, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
        transitionsBuilder: createSlideTransition(direction: 'bottom'),
      );
    },
  ),
];
