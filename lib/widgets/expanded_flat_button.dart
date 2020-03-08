import 'package:flutter/material.dart';

class ExpandedFlatButton extends StatelessWidget {
  const ExpandedFlatButton(
      {this.text, this.onPressed, this.color, this.textColor = Colors.white});
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        child: FlatButton(
          child: Container(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
          color: color,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
