import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/channel/provider/channel_provider.dart';
import 'package:flutter_application_1/features/content/Long_video/parts/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyChannelHome extends StatelessWidget {
  const MyChannelHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref
            .watch(eachCannaleProvider(FirebaseAuth.instance.currentUser!.uid))
            .when(
              data: (videoList) {
                if (videoList.isEmpty) {
                  return const Center(child: Text('No videos found.'));
                } else {
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Post(video: videoList[index]);
                          },
                          childCount: videoList.length,
                        ),
                      ),
                    ],
                  );
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
            );
      },
    );
  }
}
