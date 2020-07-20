import 'package:flutter/material.dart';
import 'package:flutter_git_search/constants/text_styles.dart';
import 'package:get/get.dart';

class ErrorDialog<T> extends AlertDialog {
  Future<T> show() async {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<void> showErrorDialog(BuildContext context, dynamic exception) =>
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'Erro',
                style: AppTextStyles.profileAttribute,
              ),
              content: Text(
                exception.toString(),
                style: AppTextStyles.profileBioDescription,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: Get.back,
                )
              ],
            ));
