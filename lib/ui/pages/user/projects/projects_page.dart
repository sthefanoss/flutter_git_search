import 'package:flutter_git_search/controllers/controller.dart';
import 'package:flutter_git_search/controllers/user_controller.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_separated_list_view.dart';
import '../../../widgets/custom_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import 'widgets/project_tile.dart';

class ProjectsPage extends StatelessWidget {
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: CustomAppBar(
        title: 'Projetos',
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: CustomSeparatedListView(
                isLoading: _userController.status.value.isAwaiting,
                itemCount: _userController.projects.length,
                itemBuilder: (_, index) => ProjectTile(
                  _userController.projects[index],
                ),
              ),
            ),
            CustomFlatButton(
                text: 'Ver Mais',
                onPressed: !_userController.hasMoreData.value &&
                        !_userController.status.value.isAwaiting
                    ? null
                    : _userController.getProjectsData),
          ],
        ),
      ),
    ));
  }
}
