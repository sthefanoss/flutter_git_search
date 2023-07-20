import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import '../models/git_user.dart';
import '../models/user_project.dart';

enum SearchType { All, Filtered }

///Busca os dados da API, dependendo do modo de pesquisa
Future<Map> fetchUsers(
    {required bool isNewSearch,
    required String searchText,
    required int pageIndex,
    required int totalCount,
    required int sinceIndex,
    required SearchType searchType}) async {
  http.Response response;
  Map<String, dynamic> dataMap = {
    'users': [],
    'totalCount': totalCount,
    'sinceIndex': sinceIndex,
    'pageIndex': pageIndex,
  };
  List parsedUserList;
  switch (searchType) {
    case SearchType.Filtered:
      response = await http.get(
        Uri.parse('https://api.github.com/search/users?q=$searchText&page=$pageIndex&per_page=10'),
      );
      parsedUserList = json.jsonDecode(response.body)["items"];
      dataMap['totalCount'] = json.jsonDecode(response.body)["total_count"];
      dataMap['pageIndex'] = pageIndex + 1;
      break;
    case SearchType.All:
      response = await http.get(
        Uri.parse('https://api.github.com/users?since=$sinceIndex&per_page=10'),
      );
      parsedUserList = json.jsonDecode(response.body);
      dataMap['sinceIndex'] = parsedUserList.last['id'];
      break;
  }
  for (final parsedUser in parsedUserList) {
    dataMap['users'].add({'id': parsedUser['login'], 'avatarUrl': parsedUser['avatar_url']});
  }
  return dataMap;
}

Future<Map> fetchProjects({required String userId, required int pageIndex}) async {
  List<Project> newProjects = [];
  final response = await http.get(
    Uri.parse('https://api.github.com/users/$userId/repos?page=$pageIndex&per_page=10'),
  );
  final parsedProjectsData = json.jsonDecode(response.body) as List;
  for (final Map projectData in parsedProjectsData) {
    newProjects.add(Project.fromJson(projectData));
  }
  return {'projects': newProjects, 'pageIndex': pageIndex + 1};
}

Future<GitUser> fetchGitUser(String userId) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/users/$userId'),
  );
  final parsedUserData = json.jsonDecode(response.body) as Map;
  return GitUser.fromJson(parsedUserData);
}
