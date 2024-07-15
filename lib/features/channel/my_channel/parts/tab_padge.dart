import 'package:flutter/material.dart';

class TabPadge extends StatelessWidget {
  const TabPadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(children: [
        Center(
          child: Text("Home"),
        ),
        Center(
          child: Text("Videos"),
        ),
        Center(
          child: Text("shorts"),
        ),
        Center(
          child: Text("Community"),
        ),
        Center(
          child: Text("PlatList"),
        ),
        Center(
          child: Text("Channels"),
        ),
        Center(
          child: Text("about"),
        )
      ]),
    );
  }
}
