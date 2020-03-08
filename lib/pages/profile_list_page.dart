import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/user_tile.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_flat_button.dart';
import '../widgets/custom_separated_listview.dart';
import '../widgets/custom_text_field.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import '../helper/error_dialog.dart';

enum SearchType { All, Filtered }

class ProfileListPage extends StatefulWidget {
  @override
  _ProfileListPageState createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  final _searchBoxController = TextEditingController();

  String _lastQuery;
  List<Map<String, dynamic>> _users = [];
  int _pageIndex = 1, _totalCount = 0, _sinceIndex = 0;
  bool _changeDependencies = true, _isLoading = false;
  SearchType _searchType;

  ///Busca os dados da API, dependendo do modo de pesquisa
  Future<List<Map<String, dynamic>>> _fetchUsers({bool isNewSearch}) async {
    http.Response response;
    List<dynamic> parsedUserList;
    try {
      switch (_searchType) {
        case SearchType.Filtered:
          response = await http.get(
              'https://api.github.com/search/users?q=${_searchBoxController.text}&page=$_pageIndex&per_page=10');
          parsedUserList = json.jsonDecode(response.body)["items"];
          _totalCount = json.jsonDecode(response.body)["total_count"];
          _pageIndex++;
          break;
        case SearchType.All:
          response = await http.get(
              'https://api.github.com/users?since=$_sinceIndex&per_page=10');
          parsedUserList = json.jsonDecode(response.body);
          _sinceIndex = parsedUserList.last['id'];
          break;
      }
      List<Map<String, dynamic>> _newUsers = [];
      for (final parsedUser in parsedUserList)
        _newUsers.add(
            {'id': parsedUser['login'], 'avatarUrl': parsedUser['avatar_url']});

      ///Retorna nova lista para substituir antiga, ou concatena os resultadoss
      return isNewSearch ? _newUsers : [..._users, ..._newUsers];
    } catch (e) {
      showErrorDialog(context, e);
      return [..._users];
    }
  }

  ///função para receber dados da tela anterior e aplicar função assíncrona na atual
  @override
  Future<void> didChangeDependencies() async {
    if (_changeDependencies) {
      _changeDependencies = false;
      final search = ModalRoute.of(context).settings.arguments;
      _searchBoxController.text = search is String ? search : '';
      await _search(isNewSearch: true);
    }
    super.didChangeDependencies();
  }

  ///Função que lida com os estados para atualizar a tela e receber novos dados
  Future<void> _search({bool isNewSearch}) async {
    ///Se o usuário tentar 'VER MAIS' com uma pesquisa diferente, isso irá
    ///garantir a persistência na pesquisa antiga
    if (isNewSearch) {
      _lastQuery = _searchBoxController.text;
      _searchType = _lastQuery.isEmpty ? SearchType.All : SearchType.Filtered;
      _pageIndex = 1;
      _sinceIndex = 0;
    } else
      setState(() {
        _searchBoxController.text = _lastQuery;
      });

    setState(() {
      _isLoading = true;
    });

    ///atualização de dados de fato
    _users = await _fetchUsers(isNewSearch: isNewSearch);
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
                  user: _users[n]['id'],
                  avatarUrl: _users[n]['avatarUrl'],
                  onTap: () => Navigator.of(context)
                      .pushNamed(kProfileRoute, arguments: _users[n]['id']),
                ),
              ),
            ),
            CustomFlatButton(
              text: 'Ver Mais',
              onPressed: _isLoading ||
                      (_users.length >= _totalCount &&
                          _searchType == SearchType.Filtered)
                  ? null
                  : () => _search(isNewSearch: false),
            )
          ],
        ),
      ),
    );
  }
}
