import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'package:freeze/core/routing/transitions.dart';
import 'pages/projects_page.dart';
import 'pages/project_detail_page.dart';

List<GoRoute> get projectsRoutes => <GoRoute>[
  GoRoute(
    path: Routes.projects,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const ProjectsPage(),
        transitionsBuilder: createSlideTransition(direction: 'top'),
      );
    },
  ),
  GoRoute(
    path: Routes.projectDetail,
    pageBuilder: (BuildContext context, GoRouterState state) {
      String projectId = state.pathParameters['id']!;

      return CustomTransitionPage(
        key: state.pageKey,
        child: ProjectDetailPage(projectId: projectId),
        transitionsBuilder: createSlideTransition(direction: 'bottom'),
      );
    },
  ),
];
