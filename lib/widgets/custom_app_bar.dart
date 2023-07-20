import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.grey,
                size: 24,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Divider(
            color: Colors.black.withOpacity(0.4),
            thickness: 1.2,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 75);
}
