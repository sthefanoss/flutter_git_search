import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {this.controller, this.onEditingComplete, this.showIcon = true});
  final TextEditingController controller;
  final VoidCallback onEditingComplete;
  final bool showIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 15, color: Colors.black),
              textInputAction: TextInputAction.search,
              onEditingComplete: onEditingComplete,
              decoration: InputDecoration(
                  hintText: 'Pesquisar...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  border: InputBorder.none),
            ),
          ),
          if (showIcon)
            GestureDetector(
              onTap: onEditingComplete,
              child: Container(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                width: 50 * 44 / 30,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
            ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: const Color(0xFF90A4AE),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(11.0),
        ),
      ),
    );
  }
}
