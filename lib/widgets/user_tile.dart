import 'package:flutter/material.dart';
import '../constants.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
    required this.avatarUrl,
    required this.onTap,
  });

  final String user;
  final String avatarUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            user,
            style: const TextStyle(color: kUserNameColor, fontWeight: FontWeight.w600),
          ),
          onTap: onTap,
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 5, color: const Color(0xFFF2F2F2), style: BorderStyle.solid)),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: FadeInImage.assetNetwork(
                placeholder: 'assets/images/git_logo.png',
                image: avatarUrl,
              ).image,
            ),
          ),
        ),
      ],
    );
  }
}
