import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'pages/login_page.dart';

List<GoRoute> get authRoutes => <GoRoute>[
  GoRoute(
    path: Routes.login,
    name: 'login',
    builder: (BuildContext context, GoRouterState state) => const LoginPage(),
  ),
];
