import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/expanded_flat_button.dart';
import '../constants.dart';
import '../widgets/git_search_logo.dart';
import '../widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchBoxController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _seeAll(BuildContext context) {
    Navigator.of(context).pushNamed(kProfileListRoute);
  }

  void _search(BuildContext context) {
    if (_searchBoxController.text.isEmpty) {
      FocusScope.of(context).requestFocus(FocusNode());
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Escreva alguma coisa!'),
        duration: Duration(seconds: 1),
      ));
    } else
      Navigator.of(context)
          .pushNamed(kProfileListRoute, arguments: _searchBoxController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: GitSearchLogo(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: CustomTextField(
                  controller: _searchBoxController, showIcon: false),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: _generateButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateButtons() => Row(
        children: <Widget>[
          ExpandedFlatButton(
            text: 'Ver Todos',
            color: Theme.of(context).primaryColor,
            onPressed: () => _seeAll(context),
          ),
          const SizedBox(
            width: 30,
          ),
          ExpandedFlatButton(
            text: 'Buscar',
            color: Theme.of(context).accentColor,
            onPressed: () => _search(context),
          ),
        ],
      );
}
