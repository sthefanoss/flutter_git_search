import 'package:flutter_git_search/ui/widgets/custom_separated_list_view.dart';
import 'package:flutter_git_search/controllers/search_controller.dart';
import 'package:flutter_git_search/ui/widgets/custom_app_bar.dart';
import 'package:flutter_git_search/ui/widgets/custom_flat_button.dart';
import 'package:flutter_git_search/ui/widgets/custom_text_field.dart';
import 'package:flutter_git_search/controllers/controller.dart';
import 'package:flutter_git_search/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'widgets/user_tile.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  final _searchController = Get.find<SearchController>();

  @override
  void initState() {
    _textController.text = Get.arguments;
    _newSearch();
    super.initState();
  }

  void _newSearch() {
    _searchController.newSearch(input: _textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: CustomAppBar(
          title: 'Lista de Usuários',
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: CustomTextField(
                  onEditingComplete: _newSearch,
                  controller: _textController,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: CustomSeparatedListView(
                  isLoading: _searchController.status.value.isAwaiting,
                  itemCount: _searchController.users.value.length,
                  itemBuilder: (ctx, n) => UserTile(
                    user: _searchController.users.value[n],
                    onTap: () => Get.toNamed(
                      RouteNames.profile(
                        _searchController.users.value[n].login,
                      ),
                    ),
                  ),
                ),
              ),
              CustomFlatButton(
                text: 'Ver Mais',
                onPressed: !_searchController.status.value.isAwaiting &&
                        !_searchController.hasMoreData.value
                    ? _searchController.nextSearch
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
