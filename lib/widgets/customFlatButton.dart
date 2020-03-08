import 'package:flutter/material.dart';


class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({this.onPressed, this.text});
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FlatButton(
        padding: EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        disabledColor: Colors.black12,
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
