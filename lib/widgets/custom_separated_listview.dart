import 'package:flutter/material.dart';

class CustomSeparatedListView extends StatelessWidget {
  const CustomSeparatedListView({
    super.key,
    required this.itemCount,
    required this.isLoading,
    required this.itemBuilder,
  });
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.separated(
        itemBuilder: itemBuilder,
        itemCount: itemCount,
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Divider(
            color: Colors.black54,
          ),
        ),
      ),
      if (isLoading) const Center(child: CircularProgressIndicator()),
    ]);
  }
}
