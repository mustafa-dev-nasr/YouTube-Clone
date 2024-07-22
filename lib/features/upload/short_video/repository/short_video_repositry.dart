import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/content/short_video/padges/short_video_padge.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/upload/short_video/model/short_video_model.dart';
import 'package:path/path.dart';

final shortVideoProvider = Provider<ShortVideoRepository>((ref) {
  return ShortVideoRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class ShortVideoRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ShortVideoRepository({
    required this.firestore,
    required this.auth,
  });

  Future<void> addShortToFirestore({
    required context,
    required String caption,
    required String video,
    required DateTime datePublished,
  }) async {
    ShortVideoModel shortVideoModel = ShortVideoModel(
      caption: caption,
      shortVideo: video,
      userId: auth.currentUser!.uid,
      datePublished: datePublished,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
    try {
      await firestore.collection('shorts').add(shortVideoModel.toMap());
    } catch (e) {
      // Handle error
      print('Error adding short video to Firestore: $e');
    }
  }
}
