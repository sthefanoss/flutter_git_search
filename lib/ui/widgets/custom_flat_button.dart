import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({this.onPressed, this.text, this.color});
  final Function onPressed;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FlatButton(
        padding: EdgeInsets.all(10),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        disabledColor: Colors.black12,
        onPressed: onPressed,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
