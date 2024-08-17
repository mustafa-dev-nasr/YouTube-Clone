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
Future<File?> pickVideo(BuildContext context) async {
  final XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
  if (file != null) {
    final File video = File(file.path);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VideoDetailsPage(video: video);
    }));
    return video;
  } else {
    showErrorSnackBar('No video selected', context);
    return null;
  }
}

Future<File?> pickShortVideo(BuildContext context) async {
  try {
    final XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file != null) {
      final File video = File(file.path);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ShortVideoScreen(shortVideo: video);
      }));
      return video;
    } else {
      showErrorSnackBar('No video selected', context);
      return null;
    }
  } catch (e) {
    // Handle any errors that may occur during video picking
    print('Error picking video: $e');
    showErrorSnackBar('Error picking video: $e', context);
    return null;
  }
}
Future<File?> pickImage() async {
  final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (file != null) {
    final File image = File(file.path);
    return image;
  } else {
    return null;
  }
}

Future<String> puttFileInStoradge(file, number, fileType) async {
  final ref = FirebaseStorage.instance.ref().child("$file/$number");
  final uploud = ref.putFile(file);
  final snapShot = await uploud;
  String downlodUrl = await snapShot.ref.getDownloadURL();
  return downlodUrl;
}
