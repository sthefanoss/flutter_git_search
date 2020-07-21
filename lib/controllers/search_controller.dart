import 'package:flutter_git_search/controllers/controller.dart';
import 'package:flutter_git_search/data/repository.dart';
import 'package:flutter_git_search/models/user.dart';
import 'package:flutter_git_search/models/search.dart';
import 'package:get/get.dart';

class SearchController extends Controller {
  final users = RxList<User>([]);
  final hasMoreData = Rx<bool>(true);
  int _pageIndex;
  int _totalCount;
  int _sinceIndex;
  String _input;
  SearchType _searchType;

  Future<void> newSearch({String input = ''}) async {
    _searchType = input.isEmpty ? SearchType.open : SearchType.filtered;
    status.value = ControllerStatus.awaiting;

    //  try {
    if (_searchType == SearchType.open) {
      final searchResponse = await Repository.getUsers(
        Search.open(sinceIndex: 0),
      );

      users.value = searchResponse.users;
      _totalCount = null;
      hasMoreData.value = false;
      _pageIndex = null;
      _sinceIndex = users.value.last.id;
      _input = null;
    } else {
      final searchResponse = await Repository.getUsers(
        Search.filtered(input: input, pageIndex: 0),
      );

      users.value = searchResponse.users;
      _totalCount = searchResponse.totalCount;
      hasMoreData.value = users.value.length >= _totalCount;
      _pageIndex = 1;
      users.value.length;
      _sinceIndex = null;
      _input = input;
    }
    //   } catch (e) {
    //    status.value = ControllerStatus.withError;
    //  }

    status.value = ControllerStatus.ok;
  }

  Future<void> nextSearch() async {
    status.value = ControllerStatus.awaiting;

    // try {
    if (_searchType == SearchType.open) {
      final searchResponse = await Repository.getUsers(
        Search.open(sinceIndex: _sinceIndex),
      );

      users.value.addAll(searchResponse.users);
      _sinceIndex = users.value.last.id;
    } else {
      final searchResponse = await Repository.getUsers(
        Search.filtered(input: _input, pageIndex: _pageIndex),
      );

      users.value.addAll(searchResponse.users);
      hasMoreData.value = users.value.length >= _totalCount;
      _pageIndex++;
    }
    // } catch (e) {
    //    status.value = ControllerStatus.withError;
    // }

    status.value = ControllerStatus.ok;
  }
}
