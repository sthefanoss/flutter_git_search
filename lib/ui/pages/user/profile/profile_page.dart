import 'package:flutter_git_search/routes/route_names.dart';
import 'package:flutter_git_search/ui/widgets/custom_flat_button.dart';
import 'package:flutter_git_search/controllers/user_controller.dart';
import 'package:flutter_git_search/ui/widgets/custom_app_bar.dart';
import 'package:flutter_git_search/controllers/controller.dart';
import 'package:flutter_git_search/constants/text_styles.dart';
import 'package:flutter_icons/flutter_icons.dart' as icons;
import 'widgets/profile_attribute.dart';
import 'package:flutter/material.dart';
import 'widgets/profile_avatar.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: CustomAppBar(title: 'Perfil'),
          body: !_userController.status.value.isOk
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    ProfileAvatar(
                      name: _userController.profile.value.name,
                      avatarUrl: _userController.profile.value.avatarUrl,
                      id: _userController.profile.value.login,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomFlatButton(
                        text: 'Ver Projetos',
                        onPressed:
                            _userController.profile.value.projectsCount == 0
                                ? null
                                : () => Get.toNamed(
                                      RouteNames.projects(
                                        Get.parameters['userId'],
                                      ),
                                    ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ..._buildAttributes(),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Bio',
                            style: AppTextStyles.profileBioTitle,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            _userController.profile.value.bio,
                            style: AppTextStyles.profileBioDescription,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  List<Widget> _buildAttributes() => [
        ProfileAttribute(
          title: _userController.profile.value.location,
          iconData: Icons.home,
        ),
        ProfileAttribute(
          title: _userController.profile.value.blog,
          iconData: Icons.phonelink,
        ),
        ProfileAttribute(
          title: 'Seguidores',
          iconData: icons.Feather.users,
          content: _userController.profile.value.followersCount.toString(),
        ),
        ProfileAttribute(
          title: 'Seguindo',
          iconData: icons.Feather.user,
          content: _userController.profile.value.fallowingCount.toString(),
        ),
        ProfileAttribute(
          title: 'Projetos',
          iconData: icons.Feather.folder,
          content: _userController.profile.value.projectsCount.toString(),
        )
      ];
}
