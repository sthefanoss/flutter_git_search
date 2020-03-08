import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/customAppBar.dart';
import '../models/git_user.dart';
import 'package:flutter_icons/flutter_icons.dart' as icons;
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import '../widgets/profile_attribute.dart';
import '../widgets/customFlatButton.dart';
import '../widgets/profile_avatar.dart';

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
      final user = ModalRoute.of(context).settings.arguments as String;
      final response = await http.get('https://api.github.com/users/$user');
      if (response.body.isEmpty) return [];
      final parsedUserData = json.jsonDecode(response.body) as Map;
      setState(() {
        _gitUser = GitUser.fromJson(parsedUserData);
        _changeDependencies = false;
      });
    }
    super.didChangeDependencies();
  }

  void _navigateToProjects(BuildContext context) {
    Navigator.of(context).pushNamed(kProjectsRoute, arguments: {
      'id': _gitUser.id,
      'projectsNumber': _gitUser.projectsNumber
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Perfil'),
        body: _changeDependencies
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            style: TextStyle(
                                fontSize: 18,
                                color: kUserNameColor,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            _gitUser.bio,
                            style: TextStyle(
                                fontSize: 16, color: const Color(0xFF263238)),
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
