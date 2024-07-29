import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final longVideoProvider = Provider(
  (ref) => VideoRepository(firebaseFirestore: FirebaseFirestore.instance),
);

class VideoRepository {
  FirebaseFirestore firebaseFirestore;

  VideoRepository({required this.firebaseFirestore});

  Future<void> uploadVideoToFirestore({
    required String title,
    required String videoUrl,
    required String description,
    required String videoId,
    required DateTime datePublished,
    required String userId,
    required String thumbnail,
  }) async {
    VideoModel video = VideoModel(
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      title: title,
      datePublished: datePublished,
      views: 0,
      videoId: videoId,
      userId: userId,
      type: "video",
      likes: [],
      description: description,
    );

    try {
      await firebaseFirestore
          .collection("video")
          .doc(videoId)
          .set(video.toMap());
      print("Video uploaded successfully");
    } catch (e) {
      print("Failed to upload video: $e");
    }
  }

  Future<void> likeVideo({
    required List? likes,
    required String videoId,
    required String currentUserId,
  }) async {
    if (likes == null) return;

    final videoDoc =
        FirebaseFirestore.instance.collection("video").doc(videoId);

    try {
      if (!likes.contains(currentUserId)) {
        await videoDoc.update({
          "likes": FieldValue.arrayUnion([currentUserId])
        });
        print("Liked video: $videoId by user: $currentUserId");
      } else {
        await videoDoc.update({
          "likes": FieldValue.arrayRemove([currentUserId])
        });
        print("Unliked video: $videoId by user: $currentUserId");
      }
    } catch (e) {
      print("Error updating likes for video $videoId: $e");
    }
  }
}
