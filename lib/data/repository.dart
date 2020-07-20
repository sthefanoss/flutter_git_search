import 'package:dio/dio.dart';
import 'package:flutter_git_search/constants/endpoints.dart';
import 'package:flutter_git_search/models/user_search.dart';
import '../models/git_user.dart';
import '../models/user_project.dart';

class Repository {
  static final _dio = Dio();

  static Future<Map> fetchUsers(UserSearch search) async {
    Response response;
    Map<String, dynamic> dataMap = {
      'users': [],
      'totalCount': search.totalCount,
      'sinceIndex': search.sinceIndex,
      'pageIndex': search.pageIndex,
    };
    List parsedUserList;
    switch (search.type) {
      case UserSearchType.filtered:
        response = await _dio.get(
          RestEndpoints.filteredSearch(
            search.searchText,
            search.pageIndex,
          ),
        );
        parsedUserList = response.data['items'];
        dataMap['totalCount'] = response.data['total_count'];
        dataMap['pageIndex'] = search.pageIndex + 1;
        break;
      case UserSearchType.all:
        response = await _dio.get(
          RestEndpoints.openSearch(
            search.sinceIndex,
          ),
        );
        parsedUserList = response.data;
        dataMap['sinceIndex'] = parsedUserList.last['id'];
        break;
    }
    for (final parsedUser in parsedUserList)
      dataMap['users'].add({
        'id': parsedUser['id'],
        'login': parsedUser['login'],
        'avatarUrl': parsedUser['avatar_url']
      });
    return dataMap;
  }

  static Future<Map> fetchProjects({String userId, int pageIndex}) async {
    List<UserProject> newProjects = [];
    final response = await _dio.get(
      RestEndpoints.userProjects(userId, pageIndex),
    );
    final parsedProjectsData = response.data;
    for (final Map projectData in parsedProjectsData)
      newProjects.add(UserProject.fromJson(projectData));
    return {'projects': newProjects, 'pageIndex': pageIndex + 1};
  }

  static Future<GitUser> fetchGitUser(String userId) async {
    final response = await _dio.get(RestEndpoints.userData(userId));
    return GitUser.fromJson(response.data);
  }
}
