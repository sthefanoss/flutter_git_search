import 'package:flutter/material.dart';
import 'package:flutter_git_search/constants/images.dart';

class GitSearchLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.transparent,
              backgroundImage: Image.asset(
                AppImages.gitLogo,
              ).image,
            ),
          ),
          Text(
            'GitSearch',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .display3
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
