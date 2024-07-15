import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/methods.dart';
import 'package:flutter_application_1/features/upload/long_video/video_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  const VideoDetailsPage({super.key, this.video});
  final File? video;
  @override
  ConsumerState<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  final titleController = TextEditingController();
  final didcriptionController = TextEditingController();
  bool isThumbnailSelected = false;
  var randomNumber = const Uuid().v4();
  var videoId = const Uuid().v4();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter the title',
              style: TextStyle(color: Colors.blueGrey, fontSize: 24),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: 'Enter the title',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Enter the Discription',
              style: TextStyle(color: Colors.blueGrey, fontSize: 24),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: didcriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                  hintText: 'Enter the Discription',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(11),
              ),
              child: TextButton(
                onPressed: () async {
                  image = await pickImage();
                  isThumbnailSelected = true;
                  setState(() {});
                },
                child: const Text(
                  'SELECT THUMBNATL',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            isThumbnailSelected
                ? Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Image.file(
                      image!,
                      cacheHeight: 160,
                      cacheWidth: 400,
                    ),
                  )
                : const SizedBox(),
            isThumbnailSelected
                ? Container(
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        //pubplish video
                        String thumbnail = await puttFileInStoradge(
                            image, randomNumber, "image");
                        String videoUrl = await puttFileInStoradge(
                            widget.video, randomNumber, "video");
                        ref.watch(longVideoProvider).uploadVideoToFirestore(
                            title: titleController.text,
                            videoUrl: videoUrl,
                            videoId: videoId,
                            datePublished: DateTime.now(),
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            thumbnail: thumbnail,
                            description: didcriptionController.text);
                      },
                      child: const Text(
                        'publish',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      )),
    );
  }
}
