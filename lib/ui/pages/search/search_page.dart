import 'package:flutter/material.dart';
import 'package:flutter_git_search/data/repository.dart';
import 'package:flutter_git_search/models/user_search.dart';
import 'package:flutter_git_search/routes/route_names.dart';
import 'package:flutter_git_search/ui/widgets/error_dialog.dart';
import 'package:get/get.dart';

import 'widgets/user_tile.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_flat_button.dart';
import '../../widgets/custom_separated_list_view.dart';
import '../../widgets/custom_text_field.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchBoxController = TextEditingController();

  String _lastQuery;
  List _users = [];
  int _pageIndex = 1, _totalCount = 0, _sinceIndex = 0;
  bool _changeDependencies = true, _isLoading = false;
  UserSearchType _userSearchType;

  @override
  Future<void> didChangeDependencies() async {
    if (_changeDependencies) {
      _changeDependencies = false;
      final String search = Get.arguments;
      _searchBoxController.text = search is String ? search : '';
      await _search(isNewSearch: true);
    }
    super.didChangeDependencies();
  }

  Future<void> _search({bool isNewSearch}) async {
    ///Se o usuário tentar 'VER MAIS' com uma pesquisa diferente, isso irá
    ///garantir a persistência na pesquisa antiga
    if (isNewSearch) {
      _lastQuery = _searchBoxController.text;
      _userSearchType =
          _lastQuery.isEmpty ? UserSearchType.all : UserSearchType.filtered;
      _pageIndex = 1;
      _sinceIndex = 0;
    } else
      setState(() {
        _searchBoxController.text = _lastQuery;
      });

    setState(() {
      _isLoading = true;
    });

    ///atualização de dados de fato, se possível
//    try {
    final Map dataMap = await Repository.fetchUsers(
      UserSearch(
          isNewSearch: isNewSearch,
          sinceIndex: _sinceIndex,
          pageIndex: _pageIndex,
          searchText: _lastQuery,
          type: _userSearchType,
          totalCount: _totalCount),
    );
    _users = isNewSearch ? dataMap['users'] : [..._users, ...dataMap['users']];
    _sinceIndex = dataMap['sinceIndex'];
    _totalCount = dataMap['totalCount'];
    _pageIndex = dataMap['pageIndex'];
    print(_users);
//    } catch (e) {print(e);
//      await ErrorDialog().show();
//    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: CustomAppBar(
          title: 'Lista de Usuários',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CustomTextField(
                onEditingComplete: () => _search(isNewSearch: true),
                controller: _searchBoxController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: CustomSeparatedListView(
                isLoading: _isLoading,
                itemCount: _users.length,
                itemBuilder: (ctx, n) => UserTile(
                  user: _users[n]['login'],
                  avatarUrl: _users[n]['avatarUrl'],
                  onTap: () => Get.toNamed(
                      RouteNames.profile(_users[n]['login'].toString())),
                ),
              ),
            ),
            CustomFlatButton(
              text: 'Ver Mais',
              onPressed: _isLoading ||
                      (_users.length >= _totalCount &&
                          _userSearchType == UserSearchType.filtered)
                  ? null
                  : () => _search(isNewSearch: false),
            )
          ],
        ),
      ),
    );
  }
}
