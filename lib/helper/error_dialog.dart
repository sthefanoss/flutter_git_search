import 'package:flutter/material.dart';
import '../constants.dart';

Future<void> showErrorDialog(BuildContext context, dynamic exception) =>
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text(
                'Erro',
                style: kProfileAttributeTextStyle,
              ),
              content: Text(
                exception.toString(),
                style: kProfileBioDescriptionTextStyle,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
