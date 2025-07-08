import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'package:freeze/core/routing/transitions.dart';
import 'pages/home_page.dart';
import 'package:freeze/features/features/presentation/pages/features_page.dart';
import 'package:freeze/features/docs/presentation/pages/docs_page.dart';

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
  GoRoute(
    path: Routes.features,
    pageBuilder: (_, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const FeaturesPage(),
        transitionsBuilder: createSlideTransition(direction: 'left'),
      );
    },
  ),
  GoRoute(
    path: Routes.docs,
    pageBuilder: (_, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const DocsPage(),
        transitionsBuilder: createSlideTransition(direction: 'left'),
      );
    },
  ),
];
