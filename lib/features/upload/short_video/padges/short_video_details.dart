import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/widgets/flat_button.dart';
import 'package:flutter_application_1/features/upload/short_video/repository/short_video_repositry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShortVideoDetails extends ConsumerStatefulWidget {
  final File shortVideo;
  const ShortVideoDetails({super.key, required this.shortVideo});

  @override
  ConsumerState<ShortVideoDetails> createState() => _ShortVideoDetailsState();
}

class _ShortVideoDetailsState extends ConsumerState<ShortVideoDetails> {
  final captionController = TextEditingController();
  final DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Video Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: captionController,
              decoration: const InputDecoration(
                  hintText: "Write a caption...",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FlatButton(
                  text: "PUBLISH",
                  onPressed: () async {
                    await ref.watch(shortVideoProvider).addShortToFirestore(
                        caption: captionController.text,
                        video: widget.shortVideo.path,
                        datePublished: date,
                        context: context);
                  },
                  colour: Colors.green),
            )
          ],
        ),
      ),
    ));
  }
}
