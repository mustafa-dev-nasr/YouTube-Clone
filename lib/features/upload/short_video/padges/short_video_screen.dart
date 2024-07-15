import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/methods.dart';
import 'package:flutter_application_1/features/upload/short_video/padges/short_video_details.dart';
import 'package:flutter_application_1/features/upload/short_video/widgets/trim_slinder.dart';
import 'package:video_editor/video_editor.dart';

class ShortVideoScreen extends StatefulWidget {
  final File shortVideo;

  const ShortVideoScreen({Key? key, required this.shortVideo})
      : super(key: key);

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> {
  late VideoEditorController _controller;
  final isExporting = ValueNotifier<bool>(false);
  final exportingPrgress = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _controller = VideoEditorController.file(
      widget.shortVideo,
      minDuration: const Duration(seconds: 3),
      maxDuration: const Duration(seconds: 60),
    );
    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> exportVideo() async {
    isExporting.value = true;
    final config = VideoFFmpegVideoEditorConfig(_controller);
    final execte = await config.getExecuteConfig();
    final String command = execte.command;
    FFmpegKit.executeAsync(
        command,
        (session) async {
          final ReturnCode? cood = await session.getReturnCode();
          if (ReturnCode.isSuccess(cood)) {
            isExporting.value = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShortVideoDetails(
                          shortVideo: widget.shortVideo,
                        )));

            // export video
          } else {
            showErrorSnackBar("Faild video can not be exported", context);
          }
        },
        null,
        (steuse) {
          exportingPrgress.value =
              config.getFFmpegProgress(steuse.getTime().toInt());
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: _controller.initialized
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: CropGridViewer.preview(controller: _controller),
                    ),
                    MyTrimSlider(
                      controller: _controller,
                      height: 45,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white),
                        child: TextButton(
                          onPressed: exportVideo,
                          child: const Text(
                            "Done",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
