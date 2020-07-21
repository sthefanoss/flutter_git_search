import 'package:flutter_git_search/models/user.dart';

class SearchResponse {
  final List<User> users;
  final int totalCount;

  const SearchResponse({this.users, this.totalCount});

  factory SearchResponse.fromJson(dynamic json) {
    if (json is List) {
      return SearchResponse(
        users: json.map((user) => User.fromJson(user)).toList(),
      );
    } else if (json is Map) {
      final List users = json['items'];
      return SearchResponse(
        totalCount: json['total_count'],
        users: users.map((user) => User.fromJson(user)).toList(),
      );
    } else
      return null;
  }
}
