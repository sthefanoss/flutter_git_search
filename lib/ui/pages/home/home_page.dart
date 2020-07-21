import 'package:flutter/material.dart';
import 'package:flutter_git_search/routes/route_names.dart';
import 'package:flutter_git_search/ui/widgets/custom_flat_button.dart';
import 'package:flutter_git_search/ui/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'widgets/git_search_logo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchBoxController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _search() {
    if (_searchBoxController.text.isEmpty) {
      FocusScope.of(context).requestFocus(FocusNode());
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Escreva alguma coisa!'),
        duration: Duration(seconds: 1),
      ));
    } else
      Get.toNamed(
        RouteNames.search(),
        arguments: _searchBoxController.text,
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: <Widget>[
            GitSearchLogo(),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: CustomTextField(
                  controller: _searchBoxController, showIcon: false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: _generateButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: CustomFlatButton(
                text: 'Ver Todos',
                onPressed: () => Get.toNamed(RouteNames.search()),
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: CustomFlatButton(
                text: 'Buscar',
                onPressed: _search,
                color: Theme.of(context).accentColor,
              ),
            ),
          )
        ],
      );

  @override
  void dispose() {
    _searchBoxController.dispose();
    super.dispose();
  }
}
