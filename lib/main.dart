import 'package:flutter_git_search/pages/profile_list_page.dart';
import 'package:flutter_git_search/pages/profile_page.dart';
import 'package:flutter_git_search/pages/projects_page.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'pages/home_page.dart';

void main() => runApp(GitSearchApp());

class GitSearchApp extends StatefulWidget {
  @override
  _GitSearchAppState createState() => _GitSearchAppState();
}

class _GitSearchAppState extends State<GitSearchApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitSearch',
      theme: ThemeData(
          fontFamily: "Montserrat",
          primaryColor: const Color(0xFF344FA5),
          accentColor: const Color(0xFF6FCF97)),
      routes: {
        kHomeRoute: (ctx) => HomePage(),
        kProfileListRoute: (ctx) => ProfileListPage(),
        kProfileRoute: (ctx) => ProfilePage(),
        kProjectsRoute: (ctx) => ProjectsPage(),
      },
    );
  }
}
