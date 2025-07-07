import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freeze/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';
import 'package:freeze/core/theme/app_theme.dart';
import 'package:freeze/features/auth/presentation/providers/auth_providers.dart';
import 'package:freeze/features/auth/presentation/routes.dart';
import 'package:freeze/features/home/presentation/routes.dart';
import 'package:freeze/features/dashboard/presentation/routes.dart';
import 'package:freeze/features/projects/presentation/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Freeze extends ConsumerStatefulWidget {
  const Freeze({super.key});

  @override
  ConsumerState<Freeze> createState() => _FreezeState();
}

class _FreezeState extends ConsumerState<Freeze> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _initializeRouter();
  }

  void _initializeRouter() {
    _router = GoRouter(
      initialLocation: Routes.home,
      redirect: (BuildContext context, GoRouterState state) {
        final AuthState authState = ref.read(authNotifierProvider);

        // Handle authentication redirects
        if (authState is AuthLoading) {
          return Routes.loading;
        }

        if (authState is AuthUnauthenticated) {
          // If user is not authenticated and trying to access protected routes
          if (state.matchedLocation.startsWith(Routes.dashboard) ||
              state.matchedLocation.startsWith(Routes.projects)) {
            return Routes.login;
          }
        }

        if (authState is AuthAuthenticated) {
          // If user is authenticated and trying to access auth pages
          if (state.matchedLocation == Routes.login) {
            return Routes.dashboard;
          }
        }

        return null;
      },
      routes: <GoRoute>[
        ...homeRoutes,
        ...authRoutes,
        ...dashboardRoutes,
        ...projectsRoutes,
        // Loading route
        GoRoute(
          path: Routes.loading,
          name: 'loading',
          builder: (BuildContext context, GoRouterState state) =>
              const _LoadingPage(),
        ),
      ],
      errorBuilder: (BuildContext context, GoRouterState state) =>
          const _ErrorPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Freeze - Flutter with ease',
      builder: (context, child) {
        Widget newChild = ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 320, end: 375, name: PHONE),
            const Breakpoint(start: 376, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 768, name: TABLET),
            const Breakpoint(
              start: 769,
              end: 1024,
              name: AppBreakpoints.laptop,
            ),
            const Breakpoint(start: 1025, end: 1440, name: DESKTOP),
            const Breakpoint(
              start: 1441,
              end: double.infinity,
              name: AppBreakpoints.ultraWide,
            ),
          ],
        );
        return newChild;
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

// Loading page
class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

// Error page
class _ErrorPage extends StatelessWidget {
  const _ErrorPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
