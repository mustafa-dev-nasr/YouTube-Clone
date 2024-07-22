import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/upload/short_video/model/short_video_model.dart';
import 'package:video_player/video_player.dart';
import "package:timeago/timeago.dart" as timeago;

class ShortVideoTile extends StatefulWidget {
  final ShortVideoModel shortVideoModel;
  const ShortVideoTile({Key? key, required this.shortVideoModel})
      : super(key: key);

  @override
  State<ShortVideoTile> createState() => _ShortVideoTileState();
}

class _ShortVideoTileState extends State<ShortVideoTile> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.shortVideoModel.shortVideo))
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Auto-play video
        _controller.setLooping(true); // Loop the video
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Expanded(
            child: Stack(
              children: [
                // Video Player
                GestureDetector(
                  onTap: () {
                    if (!_controller.value.isPlaying) {
                      _controller.play();
                    } else {
                      _controller.pause();
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                // Video overlay UI elements
                Positioned(
                  bottom: MediaQuery.sizeOf(context).height / 4,
                  right: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Action buttons
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.comment,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.share,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                              // User info
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 50,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Colors.black),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Username', // Placeholder for the username
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 1,
                  bottom: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.shortVideoModel.caption,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
