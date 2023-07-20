import 'package:flutter_git_search/helper/data_fetch.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/custom_app_bar.dart';
import '../models/git_user.dart';
import '../helper/error_dialog.dart';
import '../widgets/profile_attribute.dart';
import '../widgets/custom_flat_button.dart';
import '../widgets/profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late GitUser _gitUser;
  bool _changeDependencies = true;

  @override
  Future<void> didChangeDependencies() async {
    if (_changeDependencies) {
      final userId = ModalRoute.of(context)!.settings.arguments as String;
      try {
        _gitUser = await fetchGitUser(userId);
        setState(() {
          _changeDependencies = false;
        });
      } catch (e) {
        await showErrorDialog(context, e);
        Navigator.of(context).pop();
      }
    }
    super.didChangeDependencies();
  }

  void _navigateToProjects() {
    Navigator.of(context).pushNamed(kProjectsRoute, arguments: {
      'id': _gitUser.id,
      'projectsNumber': _gitUser.projectsNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Perfil'),
        body: _changeDependencies
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  ProfileAvatar(
                    name: _gitUser.name,
                    avatarUrl: _gitUser.avatarUrl,
                    id: _gitUser.id,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomFlatButton(
                      text: 'Ver Projetos',
                      onPressed: _gitUser.projectsNumber == '0' ? null : _navigateToProjects,
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
                        const Text(
                          'Bio',
                          style: kProfileBioTitleTextStyle,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          _gitUser.bio,
                          style: kProfileBioDescriptionTextStyle,
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
          iconData: Icons.place,
        ),
        ProfileAttribute(
          title: _gitUser.blog.toString(),
          iconData: Icons.link,
        ),
        ProfileAttribute(
          title: 'Seguidores',
          iconData: Icons.people,
          content: _gitUser.followersNumber,
        ),
        ProfileAttribute(
          title: 'Seguindo',
          iconData: Icons.people,
          content: _gitUser.fallowingNumber,
        ),
        ProfileAttribute(
          title: 'Projetos',
          iconData: Icons.folder_copy,
          content: _gitUser.projectsNumber,
        )
      ];
}
