import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/cores/screens/loader.dart';
import 'package:flutter_application_1/features/content/Long_video/parts/post.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("video").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else if (snapshot.hasError) {
          return const ErrorPage();
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No videos available"));
        }

        final videoDocs = snapshot.data!.docs;
        final videos = videoDocs.map((doc) {
          return VideoModel.fromMap(doc.data());
        }).toList();

        return ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return Post(
              video: videos[index],
            );
          },
        );
      },
    );
  }
}
