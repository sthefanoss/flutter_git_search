import 'package:flutter_git_search/constants/text_styles.dart';
import 'package:flutter_git_search/data/repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_git_search/models/git_user.dart';
import 'package:flutter_git_search/routes/route_names.dart';
import 'package:flutter_git_search/ui/widgets/error_dialog.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_app_bar.dart';

import 'package:flutter_icons/flutter_icons.dart' as icons;
import 'widgets/profile_attribute.dart';
import '../../../widgets/custom_flat_button.dart';
import 'widgets/profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GitUser _gitUser;
  bool _changeDependencies = true;

  @override
  Future<void> didChangeDependencies() async {
    if (_changeDependencies) {
      final userId = Get.parameters['userId'];
      try {
        _gitUser = await Repository.fetchGitUser(userId);
        setState(() {
          _changeDependencies = false;
        });
      } catch (e) {
        await ErrorDialog().show();
      }
    }
    super.didChangeDependencies();
  }

  void _navigateToProjects(BuildContext context) {
    Get.toNamed(
      RouteNames.projects(_gitUser.id),
      arguments: {
        'projectsNumber': _gitUser.projectsNumber,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Perfil'),
        body: _changeDependencies
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  ProfileAvatar(
                    name: _gitUser.name,
                    avatarUrl: _gitUser.avatarUrl,
                    id: _gitUser.id,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomFlatButton(
                      text: 'Ver Projetos',
                      onPressed: _gitUser.projectsNumber == '0'
                          ? null
                          : () => _navigateToProjects(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ..._generateAttributes(),
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
                          _gitUser.bio,
                          style: AppTextStyles.profileBioDescription,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  List<Widget> _generateAttributes() => [
        ProfileAttribute(
          title: _gitUser.location,
          iconData: Icons.home,
        ),
        ProfileAttribute(
          title: _gitUser.blog.toString(),
          iconData: Icons.phonelink,
        ),
        ProfileAttribute(
          title: 'Seguidores',
          iconData: icons.Feather.users,
          content: _gitUser.followersNumber,
        ),
        ProfileAttribute(
          title: 'Seguindo',
          iconData: icons.Feather.user,
          content: _gitUser.fallowingNumber,
        ),
        ProfileAttribute(
          title: 'Projetos',
          iconData: icons.Feather.folder,
          content: _gitUser.projectsNumber,
        )
      ];
}
