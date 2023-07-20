import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/git_search_logo.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_flat_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchBoxController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _seeAll() {
    Navigator.of(context).pushNamed(kProfileListRoute);
  }

  void _search() {
    Navigator.of(context).pushNamed(kProfileListRoute, arguments: _searchBoxController.text);
  }

  @override
  void dispose() {
    _searchBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: <Widget>[
            const GitSearchLogo(),
            CustomTextField(
              controller: _searchBoxController,
              showIcon: false,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: CustomFlatButton(
                    text: 'Ver Todos',
                    onPressed: _seeAll,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ListenableBuilder(
                    listenable: _searchBoxController,
                    builder: (_, __) {
                      // Using [ListenableBuilder] to update bellow button when user change text input.
                      // It works because [_searchBoxController] emits a event every time text change.

                      final hasInput = _searchBoxController.text.isNotEmpty;
                      return CustomFlatButton(
                        text: 'Buscar',
                        onPressed: hasInput ? _search : null,
                        color: Theme.of(context).colorScheme.secondary,
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
