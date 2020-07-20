class RouteNames {
  static home() => '/';
  static search() => '/search';
  static profile([String userId = ':userId']) => '/profile/$userId';
  static projects([String userId = ':userId']) => '/profile/$userId/projects';
}
