import 'package:flutter_git_search/models/search.dart';

class RestEndpoints {
  static String filteredSearch(Search search) {
    return 'https://api.github.com/search/users?q=${search.input}&page=${search.pageIndex}&per_page=10';
  }

  static String openSearch(Search search) {
    return 'https://api.github.com/users?since=${search.sinceIndex}&per_page=10';
  }

  static String userProjects(String userId, int pageIndex) {
    return 'https://api.github.com/users/$userId/repos?page=$pageIndex&per_page=10';
  }

  static String userData(String userId) {
    return 'https://api.github.com/users/$userId';
  }
}
