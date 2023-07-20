import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileAttribute extends StatelessWidget {
  const ProfileAttribute({
    super.key,
    required this.title,
    required this.iconData,
    this.content,
  });

  final IconData iconData;
  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Icon(iconData, color: kUserNameColor),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              title,
              style: kProfileAttributeTextStyle,
            ),
          ),
          const SizedBox(width: 20),
          if (content != null)
            Text(
              content!,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF868686),
                fontWeight: FontWeight.w600,
              ),
            )
        ],
      ),
    );
  }
}
