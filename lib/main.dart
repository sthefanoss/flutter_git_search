import 'package:flutter_git_search/constants/texts.dart';
import 'package:flutter_git_search/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(GitSearchApp());

class GitSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppTexts.appName,
      getPages: pages,
    );
  }
}
