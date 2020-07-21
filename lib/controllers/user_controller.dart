import 'package:flutter_git_search/controllers/controller.dart';
import 'package:flutter_git_search/data/repository.dart';
import 'package:flutter_git_search/models/profile.dart';
import 'package:flutter_git_search/models/project.dart';
import 'package:get/get.dart';

class UserController extends Controller {
  final profile = Rx<Profile>();
  final projects = RxList<Project>();
  final hasMoreData = Rx<bool>(true);
  String _userId;
  int _pageIndex;

  @override
  Future<void> onInit() async {
    _userId = Get.parameters['userId'];
    _pageIndex = 0;
    await getProfileData();
    projects.value = [];
    super.onInit();
  }

  Future<void> getProfileData() async {
    status.value = ControllerStatus.awaiting;

    //  try {
    profile.value = await Repository.getUserProfile(userId: _userId);
    status.value = ControllerStatus.ok;
    //  } catch (e) {
    //status.value = ControllerStatus.withError;
    // }
  }

  Future<void> getProjectsData() async {
    status.value = ControllerStatus.awaiting;

    //  try {
    final responseProjects = await Repository.getUserProjects(
      userId: _userId,
      pageIndex: _pageIndex,
    );
    projects.addAll(responseProjects);
    _pageIndex++;
    hasMoreData.value = projects.length >= profile.value.projectsCount;
    status.value = ControllerStatus.ok;
    //  } catch (e) {
    //status.value = ControllerStatus.withError;
    // }
  }
}
