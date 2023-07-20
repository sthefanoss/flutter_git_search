import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.onEditingComplete,
    this.showIcon = true,
  });

  final TextEditingController controller;
  final VoidCallback? onEditingComplete;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: const Color(0xFF90A4AE),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(11.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 15, color: Colors.black),
              textInputAction: TextInputAction.search,
              onEditingComplete: onEditingComplete,
              decoration: const InputDecoration(
                hintText: 'Pesquisar...',
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                border: InputBorder.none,
              ),
            ),
          ),
          if (showIcon)
            Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: InkWell(
                onTap: onEditingComplete,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: const SizedBox(
                  width: 50 * 44 / 30,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
