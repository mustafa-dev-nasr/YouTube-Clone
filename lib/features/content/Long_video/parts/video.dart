import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/colors.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/cores/screens/loader.dart';
import 'package:flutter_application_1/cores/widgets/flat_button.dart';
import 'package:flutter_application_1/features/account/comment/comment_sheet.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/auth/provider/user_porvider.dart';
import 'package:flutter_application_1/features/content/Long_video/parts/post.dart';
import 'package:flutter_application_1/features/content/Long_video/widgets/video_externel_buttons.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class Video extends ConsumerStatefulWidget {
  final VideoModel video;
  const Video({Key? key, required this.video}) : super(key: key);

  @override
  ConsumerState<Video> createState() => _VideoState();
}

class _VideoState extends ConsumerState<Video> {
  late VideoPlayerController _controller;
  bool isShowIcon = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
  }

  toggleVideoPlayer() {
    if (_controller.value.isPlaying) {
      //paus the video
      _controller.pause();
      isPlaying = false;
      setState(() {});
    } else {
      //play the video
      _controller.play();
      isPlaying = true;
      setState(() {});
    }
  }

  goBackword() {
    Duration position = _controller.value.position;
    position = position - const Duration(seconds: 1);
    _controller.seekTo(position);
  }

  goForword() {
    Duration position = _controller.value.position;
    position = position + const Duration(seconds: 1);
    _controller.seekTo(position);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user =
        ref.watch(anyUserDataProvder(widget.video.userId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: GestureDetector(
                      onTap: isShowIcon
                          ? () {
                              isShowIcon = false;
                              setState(() {});
                            }
                          : () {
                              isShowIcon = true;
                              setState(() {});
                            },
                      child: Stack(
                        children: [
                          VideoPlayer(_controller),
                          isShowIcon
                              ? Positioned(
                                  left: 170,
                                  top: 92,
                                  child: GestureDetector(
                                    onTap: toggleVideoPlayer,
                                    child: SizedBox(
                                      height: 50,
                                      child: Image.asset(
                                        'assets/images/play.png',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          isShowIcon
                              ? Positioned(
                                  right: 55,
                                  top: 94,
                                  child: GestureDetector(
                                    onTap: goForword,
                                    child: SizedBox(
                                      height: 50,
                                      child: Image.asset(
                                        'assets/images/go_back_final.png',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          isShowIcon
                              ? Positioned(
                                  left: 48,
                                  top: 94,
                                  child: GestureDetector(
                                    onTap: goBackword,
                                    child: SizedBox(
                                      height: 50,
                                      child: Image.asset(
                                        'assets/images/go ahead final.png',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 7.5,
                              child: VideoProgressIndicator(
                                _controller,
                                allowScrubbing: true,
                                colors: const VideoProgressColors(
                                    playedColor: Colors.red,
                                    bufferedColor: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Padding(
                    padding: EdgeInsets.only(bottom: 90),
                    child: Loader(),
                  ))),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 4),
                  child: Text(
                    widget.video.title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7, top: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          widget.video.views == 0
                              ? "No views"
                              : "${widget.video.views.toString()} views",
                          style: const TextStyle(
                            fontSize: 13.4,
                            color: Color(0xff5F5F5F),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 8),
                        child: Text(
                          widget.video.datePublished.day.toString(),
                          style: const TextStyle(
                            fontSize: 13.4,
                            color: Color(0xff5F5F5F),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 9,
                    right: 9,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            CachedNetworkImageProvider(user.value!.profilepic),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 5,
                        ),
                        child: Text(
                          user.value!.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 6, left: 6, bottom: 18),
                        child: Text(
                          user.value!.subscriptions.isEmpty
                              ? "No subscriptions"
                              : "${user.value!.subscriptions.length} subscriptions",
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: FlatButton(
                                text: "Subscribe",
                                onPressed: () {},
                                colour: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 9, top: 10.5, right: 9, bottom: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 6,
                          ),
                          decoration: const BoxDecoration(
                            color: softBlueGreyBackGround,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.thumb_up,
                                  size: 15.5,
                                ),
                              ),
                              const SizedBox(width: 19),
                              const Icon(
                                Icons.thumb_down,
                                size: 15.5,
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 9, right: 9),
                          child: VideoExtraButton(
                            text: "Share",
                            iconData: Icons.share,
                          ),
                        ),
                        const VideoExtraButton(
                          text: "Remix",
                          iconData: Icons.analytics_outlined,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 9, right: 9),
                          child: VideoExtraButton(
                            text: "Download",
                            iconData: Icons.download,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //comment Box
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>  CommentSheet(widget.video));
              },
              child: Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey.shade300),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("video")
                    .where("videoId", isNotEqualTo: widget.video.videoId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const ErrorPage();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Loader();
                  }

                  final videosMap = snapshot.data!.docs;
                  final videos = videosMap
                      .map(
                        (video) => VideoModel.fromMap(video.data()),
                      )
                      .toList();
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return Post(
                        video: videos[index],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
