class Routes {
  // Public routes
  static const String home = '/';
  static const String login = '/login';
  static const String loading = '/loading';
  static const String features = '/features';
  static const String docs = '/docs';
  static const String about = '/about';
  static const String contact = '/contact';

  // Protected routes
  static const String dashboard = '/dashboard';
  static const String projects = '/projects';
  static const String projectDetail = '/projects/:id';

  // Helper methods
  static String projectDetailWithId(String id) => '/projects/$id';
}
