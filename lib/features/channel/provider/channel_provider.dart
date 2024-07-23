import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the provider with a parameter for userId
final eachCannaleProvider = FutureProvider.family((ref, userId) async {
  // Fetch videos from Firestore based on userId
  final videoMap = await FirebaseFirestore.instance
      .collection("video")
      .where("userId", isEqualTo: userId)
      .get();

  // Return the list of documents
  final videos = videoMap.docs;
  final List<VideoModel> videoList =
      videos.map((videos) => VideoModel.fromMap(videos.data())).toList();
  return videoList;
});
