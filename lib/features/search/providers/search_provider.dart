import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allVideoProvider = Provider((ref) async {
  final videosMap = await FirebaseFirestore.instance.collection('video').get();
  List<VideoModel> videos =
      videosMap.docs.map((video) => VideoModel.fromMap(video.data())).toList();
  return videos;
});

final allCanalProvider = Provider((ref) async {
  final videosMap = await FirebaseFirestore.instance.collection('users').get();
  List<UserModel> userss =
      videosMap.docs.map((users) => UserModel.fromMap(users.data())).toList();
  return userss;
});
