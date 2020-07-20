class RestEndpoints {
  static String filteredSearch(String input, int pageIndex) {
    return 'https://api.github.com/search/users?q=$input&page=$pageIndex&per_page=10';
  }

  static String openSearch(int sinceIndex) {
    return 'https://api.github.com/users?since=$sinceIndex&per_page=10';
  }

  static String userProjects(String userId, int pageIndex) {
    return 'https://api.github.com/users/$userId/repos?page=$pageIndex&per_page=10';
  }

  static String userData(String userId) {
    return 'https://api.github.com/users/$userId';
  }
}
