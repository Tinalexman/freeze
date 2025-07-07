import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'pages/projects_page.dart';

List<GoRoute> get projectsRoutes => <GoRoute>[
  GoRoute(
    path: Routes.projects,
    name: 'projects',
    builder: (BuildContext context, GoRouterState state) =>
        const ProjectsPage(),
  ),
  GoRoute(
    path: Routes.projectDetail,
    name: 'project-detail',
    builder: (BuildContext context, GoRouterState state) {
      final String projectId = state.pathParameters['id']!;
      return ProjectDetailPage(projectId: projectId);
    },
  ),
];
