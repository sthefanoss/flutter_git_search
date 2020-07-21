import 'package:flutter_git_search/controllers/user_controller.dart';
import 'package:get/get.dart';

class GitUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}
