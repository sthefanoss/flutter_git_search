import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/user_tile.dart';
import '../widgets/customAppBar.dart';
import '../widgets/customFlatButton.dart';
import '../constants.dart';
import '../widgets/custom_text_field.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import '../models/git_user.dart';

class ProfileListPage extends StatefulWidget {
  @override
  _ProfileListPageState createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  final _searchBoxController = TextEditingController();

  String _lastQuery;
  List<Map<String, dynamic>> _users = [];
  int _page = 1, _totalCount = 0, _since = 0;
  bool _changeDependencies = true, _isLoading = false;

  Future<List<Map<String, dynamic>>> _fetchUsers({bool isNewSearch}) async {
    http.Response response;
    List<dynamic> parsedUserList;
    if (_searchBoxController.text.isNotEmpty) {
      _page = isNewSearch ? 1 : _page + 1;
      response = await http.get(
          'https://api.github.com/search/users?q=${_searchBoxController.text}&page=$_page&per_page=10');
      print(response.body);
      if (response.body.isEmpty) return [];
      parsedUserList = json.jsonDecode(response.body)["items"];
      _totalCount = json.jsonDecode(response.body)["total_count"];
    } else {
      if (isNewSearch) _since = 0;
      response = await http.get('https://api.github.com/users?since=$_since');
      print(response.body);
      if (response.body.isEmpty) return [];
      parsedUserList = json.jsonDecode(response.body);
      _since = parsedUserList.last['id'];
    }
    List<Map<String, dynamic>> _newUsers = [];
    for (final parsedUser in parsedUserList)
      _newUsers.add(
          {'id': parsedUser['login'], 'avatarUrl': parsedUser['avatar_url']});

    ///Retorna nova lista para substituir antiga, ou concatena os resultadoss
    return isNewSearch ? _newUsers : [..._users, ..._newUsers];
  }

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
    print('since:$_since page:$_page');
    if (isNewSearch) {
      _lastQuery = _searchBoxController.text;
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
              child: Stack(children: [
                ListView.separated(
                  itemBuilder: (context, n) => UserTile(
                    user: _users[n]['id'],
                    avatarUrl: _users[n]['avatarUrl'],
                    onTap: () => Navigator.of(context)
                        .pushNamed(kProfileRoute, arguments: _users[n]['id']),
                  ),
                  itemCount: _users.length,
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Divider(
                      color: Colors.black54,
                    ),
                  ),
                ),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ]),
            ),
            CustomFlatButton(
              text: 'Ver Mais',
              onPressed: _isLoading || (_users.length >= _totalCount&&_lastQuery.isNotEmpty)
                  ? null
                  : () => _search(isNewSearch: false),
            )
          ],
        ),
      ),
    );
  }
}
