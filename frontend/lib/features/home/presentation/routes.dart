import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'pages/home_page.dart';

List<GoRoute> get homeRoutes => <GoRoute>[
  GoRoute(
    path: Routes.home,
    name: 'home',
    builder: (BuildContext context, GoRouterState state) => const HomePage(),
  ),
];
