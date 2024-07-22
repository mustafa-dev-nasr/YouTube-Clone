import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/cores/screens/loader.dart';
import 'package:flutter_application_1/features/content/short_video/widgets/short_video_tile.dart';
import 'package:flutter_application_1/features/upload/short_video/model/short_video_model.dart';

class ShortVideoPage extends StatelessWidget {
  const ShortVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("shorts").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (snapshot.hasError) {
              return const ErrorPage();
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No videos available"));
            }

            return PageView.builder(
              scrollDirection: Axis.vertical, // Scroll vertically
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final shortVideoMaps = snapshot.data!.docs;
                ShortVideoModel videos =
                    ShortVideoModel.fromMap(shortVideoMaps[index].data());
                return ShortVideoTile(
                  shortVideoModel: videos,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
