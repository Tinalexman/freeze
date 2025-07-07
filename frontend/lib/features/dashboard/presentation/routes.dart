import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'pages/dashboard_page.dart';

List<GoRoute> get dashboardRoutes => <GoRoute>[
  GoRoute(
    path: Routes.dashboard,
    name: 'dashboard',
    builder: (BuildContext context, GoRouterState state) =>
        const DashboardPage(),
  ),
];
