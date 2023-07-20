import 'package:flutter/material.dart';

class GitSearchLogo extends StatelessWidget {
  const GitSearchLogo({super.key});

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
                'assets/images/git_logo.png',
              ).image,
            ),
          ),
          Text(
            'GitSearch',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
