import 'package:flutter/material.dart';
import 'package:flutter_git_search/constants/colors.dart';
import 'package:flutter_git_search/constants/text_styles.dart';

class ProfileAttribute extends StatelessWidget {
  ProfileAttribute({this.title, this.iconData, this.content});

  final IconData iconData;
  final String title, content;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            color:  AppColors.darkPrimary,
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              title,
              style: AppTextStyles.profileAttribute,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          content != null
              ? Text(content,
                  style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF868686),
                      fontWeight: FontWeight.w600))
              : Container()
        ],
      ),
    );
  }
}
