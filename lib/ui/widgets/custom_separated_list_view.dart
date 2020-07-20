import 'package:flutter/material.dart';

class CustomSeparatedListView extends StatelessWidget {
  const CustomSeparatedListView(
      {this.itemCount, this.isLoading, this.itemBuilder});
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.separated(
        itemBuilder: itemBuilder,
        itemCount: itemCount,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Divider(
            color: Colors.black54,
          ),
        ),
      ),
      if (isLoading)
        Center(
          child: CircularProgressIndicator(),
        ),
    ]);
  }
}
