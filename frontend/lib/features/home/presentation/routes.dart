import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'package:freeze/core/routing/transitions.dart';
import 'pages/home_page.dart';

List<GoRoute> get homeRoutes => <GoRoute>[
  GoRoute(
    path: Routes.home,
    pageBuilder: (_, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: createSlideTransition(direction: 'right'),
      );
    },
  ),
];
