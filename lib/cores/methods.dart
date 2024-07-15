// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/upload/long_video/video_details_page.dart';
import 'package:flutter_application_1/features/upload/short_video/padges/short_video_screen.dart';
import 'package:image_picker/image_picker.dart';

void showErrorSnackBar(String message, context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
Future pickVideo(context) async {
  XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
  File video = File(file!.path);

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return VideoDetailsPage(
      video: video,
    );
  }));
  return video;
}

Future pickShortVideo(context) async {
  XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
  File video = File(file!.path);

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return ShortVideoScreen(
      shortVideo: video,
    );
  }));
  return video;
}

Future<File?> pickImage() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  File image = File(file!.path);

  return image;
}

Future<String> puttFileInStoradge(file, number, fileType) async {
  final ref = FirebaseStorage.instance.ref().child("$file/$number");
  final uploud = ref.putFile(file);
  final snapShot = await uploud;
  String downlodUrl = await snapShot.ref.getDownloadURL();
  return downlodUrl;
}
