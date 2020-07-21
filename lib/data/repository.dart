import 'package:dio/dio.dart';
import 'package:flutter_git_search/constants/endpoints.dart';
import 'package:flutter_git_search/models/profile.dart';
import 'package:flutter_git_search/models/project.dart';
import 'package:flutter_git_search/models/search_response.dart';
import 'package:flutter_git_search/models/search.dart';

class Repository {
  static final _dio = Dio();

  static Future<SearchResponse> getUsers(Search search) async {
    if (search.type == SearchType.open) {
      final response = await _dio.get(RestEndpoints.openSearch(search));
      return SearchResponse.fromJson(response.data);
    } else {
      final response = await _dio.get(RestEndpoints.filteredSearch(search));
      print(response.data);
      return SearchResponse.fromJson(response.data);
    }
  }

  static Future<List<Project>> getUserProjects(
      {String userId, int pageIndex}) async {
    final response =
        await _dio.get(RestEndpoints.userProjects(userId, pageIndex));
    print(response.data);
    final List projects = response.data;
    return projects.map((project) => Project.fromJson(project)).toList();
  }

  static Future<Profile> getUserProfile({String userId}) async {
    final response = await _dio.get(RestEndpoints.userData(userId));
    return Profile.fromJson(response.data);
  }
}
