import 'package:flutter_git_search/routes/route_names.dart';
import 'package:flutter_git_search/ui/pages/home/home_page.dart';
import 'package:flutter_git_search/ui/pages/search/search_page.dart';
import 'package:flutter_git_search/ui/pages/user/profile/profile_page.dart';
import 'package:flutter_git_search/ui/pages/user/projects/projects_page.dart';
import 'package:get/get.dart';

List<GetPage> get pages => [
      GetPage(
        page: () => HomePage(),
        name: RouteNames.home(),
      ),
      GetPage(
        page: () => SearchPage(),
        name: RouteNames.search(),
      ),
      GetPage(
        page: () => ProfilePage(),
        name: RouteNames.profile(),
      ),
      GetPage(
        page: () => ProjectsPage(),
        name: RouteNames.projects(),
      ),
    ];
