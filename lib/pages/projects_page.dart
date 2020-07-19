import 'package:flutter_git_search/helper/data_fetch.dart';
import '../widgets/custom_separated_listview.dart';
import '../widgets/custom_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../models/user_project.dart';
import '../widgets/project_tile.dart';
import '../helper/error_dialog.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool _changeDependencies = true, _isLoading = false;
  int _pageIndex = 1, _userProjectsNumber = 0;
  String _userId;
  List<Project> _projects = [];

  Future<void> _fetchProjects() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final fetchedData =
          await fetchProjects(userId: _userId, pageIndex: _pageIndex);
      _projects = [..._projects, ...fetchedData['projects']];
      _pageIndex = fetchedData['pageIndex'];
    } catch (e) {
      showErrorDialog(context, e);
    }
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
            child: CustomSeparatedListView(
              isLoading: _isLoading,
              itemCount: _projects.length,
              itemBuilder: (ctx, n) => ProjectTile(_projects[n]),
            ),
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
