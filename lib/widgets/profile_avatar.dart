import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.name,
    required this.id,
    required this.avatarUrl,
  });

  final String avatarUrl;
  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                border: Border.all(width: 5, color: const Color(0xFFECEFF1), style: BorderStyle.solid)),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.transparent,
              backgroundImage: FadeInImage.assetNetwork(
                placeholder: 'assets/images/git_logo.png',
                image: avatarUrl,
              ).image,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: kUserNameColor),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.person,
                color: Color(0xFF90A4AE),
              ),
              Text(
                id,
                style: const TextStyle(color: Color(0xFF90A4AE), fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
