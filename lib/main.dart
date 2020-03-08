import 'package:atlas_flutter_test/pages/profile_list_page.dart';
import 'package:atlas_flutter_test/pages/profile_page.dart';
import 'package:atlas_flutter_test/pages/projects_page.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'pages/home_page.dart';

void main() => runApp(AtlasTestApp());

class AtlasTestApp extends StatefulWidget {
  @override
  _AtlasTestAppState createState() => _AtlasTestAppState();
}

class _AtlasTestAppState extends State<AtlasTestApp> {
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
