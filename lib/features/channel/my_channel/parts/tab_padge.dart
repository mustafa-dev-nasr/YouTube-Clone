import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/channel/my_channel/pages/my_channel_home.dart';

class TabPadge extends StatelessWidget {
  const TabPadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(children: [
        MyChannelHome(),
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
