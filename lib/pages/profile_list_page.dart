import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/user_tile.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_flat_button.dart';
import '../widgets/custom_separated_listview.dart';
import '../widgets/custom_text_field.dart';
import '../helper/error_dialog.dart';
import '../helper/data_fetch.dart';

class ProfileListPage extends StatefulWidget {
  @override
  _ProfileListPageState createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  final _searchBoxController = TextEditingController();

  String _lastQuery;
  List _users = [];
  int _pageIndex = 1, _totalCount = 0, _sinceIndex = 0;
  bool _changeDependencies = true, _isLoading = false;
  SearchType _searchType;

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

    ///atualização de dados de fato, se possível
    try {
      final Map dataMap = await fetchUsers(
          isNewSearch: isNewSearch,
          sinceIndex: _sinceIndex,
          pageIndex: _pageIndex,
          searchText: _lastQuery,
          searchType: _searchType,
          totalCount: _totalCount);
      _users =
          isNewSearch ? dataMap['users'] : [..._users, ...dataMap['users']];
      _sinceIndex = dataMap['sinceIndex'];
      _totalCount = dataMap['totalCount'];
      _pageIndex = dataMap['pageIndex'];
    } catch (e) {
      await showErrorDialog(context, e);
    }
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
