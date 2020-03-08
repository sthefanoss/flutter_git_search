import 'package:flutter/material.dart';
import '../constants.dart';

class UserTile extends StatelessWidget {
  const UserTile({this.user, this.avatarUrl, this.onTap});
  final String user, avatarUrl;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            user,
            style:
                TextStyle(color: kUserNameColor, fontWeight: FontWeight.w600),
          ),
          onTap: onTap,
          leading: Container(
            child: CircleAvatar(
              radius: 25, backgroundColor: Colors.white,
              backgroundImage: FadeInImage.assetNetwork(
                placeholder: 'assets/images/git_logo.png',
                image: avatarUrl,
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
