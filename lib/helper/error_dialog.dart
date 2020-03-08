import 'package:flutter/material.dart';
import '../constants.dart';

Future<void> showErrorDialog(BuildContext context, Exception exception) =>
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'Erro',
                style: kProfileAttributeTextStyle,
              ),
              content: Text(
                exception.toString(),
                style: kProfileBioDescriptionTextStyle,
              ),
              actions: <Widget>[
                FlatButton(
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
