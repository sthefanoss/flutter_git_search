import 'package:flutter/material.dart';
import 'package:flutter_git_search/constants/colors.dart';
import 'package:flutter_git_search/models/user.dart';

class UserTile extends StatelessWidget {
  const UserTile({this.user, this.onTap});
  final User user;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            user.login,
            style: TextStyle(
                color: AppColors.darkPrimary, fontWeight: FontWeight.w600),
          ),
          onTap: onTap,
          leading: Container(
            child: CircleAvatar(
              radius: 25, backgroundColor: Colors.white,
              backgroundImage: FadeInImage.assetNetwork(
                placeholder: 'assets/images/git_logo.png',
                image: user.avatarUrl,
              ).image,

              // backgroundColor: Colors.transparent,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    width: 5,
                    color: const Color(0xFFF2F2F2),
                    style: BorderStyle.solid)),
          ),
        ),
      ],
    );
  }
}
