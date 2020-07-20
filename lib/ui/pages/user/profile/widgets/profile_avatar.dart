import 'package:flutter/material.dart';
import 'package:flutter_git_search/constants/colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({this.name, this.id, this.avatarUrl});
  final String avatarUrl, name, id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Container(
            child: CircleAvatar(
              radius: 60, backgroundColor: Colors.transparent,
              backgroundImage: FadeInImage.assetNetwork(
                placeholder: 'assets/images/git_logo.png',
                image: avatarUrl,
              ).image,

              // backgroundColor: Colors.transparent,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                border: Border.all(
                    width: 5,
                    color: const Color(0xFFECEFF1),
                    style: BorderStyle.solid)),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkPrimary),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.person,
                color: const Color(0xFF90A4AE),
              ),
              Text(
                id,
                style: TextStyle(color: const Color(0xFF90A4AE), fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
