import 'package:atlas_flutter_test/constants.dart';

import '../widgets/customFlatButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as json;
import 'package:http/http.dart' as http;
import '../widgets/customAppBar.dart';
import '../models/user_project.dart';
import '../widgets/project_tile.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _changeDependencies = true, _isLoading = false;
  int _page = 1, _userProjectsNumber = 0;
  String _userId;
  List<Project> _projects = [];

  Future<void> _fetchProjects() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(
        'https://api.github.com/users/$_userId/repos?page=${_page++}&per_page=10');
    print(response.body);
    if (response.body.isEmpty) return;
    final parsedProjectsData = json.jsonDecode(response.body) as List;
    for (final Map projectData in parsedProjectsData)
      _projects.add(Project.fromJson(projectData));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    if (_changeDependencies) {
      _changeDependencies = false;
      final userData = ModalRoute.of(context).settings.arguments as Map;
      _userId = userData['id'];
      _userProjectsNumber = int.parse(userData['projectsNumber']);
      await _fetchProjects();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: CustomAppBar(
        title: 'Projetos',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Stack(children: [
              ListView.separated(
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Divider(
                    color: Colors.black54,
                  ),
                ),
                itemBuilder: (ctx, n) => ProjectTile(_projects[n]),
                itemCount: _projects.length,
              ),
              if (_isLoading) Center(child: CircularProgressIndicator()),
            ]),
          ),
          CustomFlatButton(
              text: 'Ver Mais',
              onPressed: _isLoading || _projects.length >= _userProjectsNumber
                  ? null
                  : _fetchProjects),
        ],
      ),
    ));
  }
}
