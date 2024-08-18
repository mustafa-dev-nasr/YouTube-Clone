import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/cores/colors.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/cores/screens/loader.dart';
import 'package:flutter_application_1/cores/widgets/flat_button.dart';
import 'package:flutter_application_1/features/account/comment/comment_provider.dart';
import 'package:flutter_application_1/features/account/comment/comment_sheet.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/auth/provider/user_porvider.dart';
import 'package:flutter_application_1/features/content/Long_video/parts/post.dart';
import 'package:flutter_application_1/features/content/Long_video/widgets/video_externel_buttons.dart';
import 'package:flutter_application_1/features/content/Long_video/widgets/video_first_comment.dart';
import 'package:flutter_application_1/features/upload/comment/comment_model.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';
import 'package:flutter_application_1/features/upload/long_video/video_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../../channel/my_channel/repository/subscribe_respository.dart';

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
      // Pause the video
      _controller.pause();
      isPlaying = false;
      setState(() {});
    } else {
      // Play the video
      _controller.play();
      isPlaying = true;
      setState(() {});
    }
  }

  goBackward() {
    Duration position = _controller.value.position;
    position = position - const Duration(seconds: 1);
    _controller.seekTo(position);
  }

  goForward() {
    Duration position = _controller.value.position;
    position = position + const Duration(seconds: 1);
    _controller.seekTo(position);
  }

  Future<void> likeVideo() async {
    await ref.watch(longVideoProvider).likeVideo(
          likes: widget.video.likes,
          videoId: widget.video.videoId,
          currentUserId: FirebaseAuth.instance.currentUser!.uid,
        );

    // Update the UI to reflect the new likes
    setState(() {
      if (widget.video.likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
        widget.video.likes.remove(FirebaseAuth.instance.currentUser!.uid);
      } else {
        widget.video.likes.add(FirebaseAuth.instance.currentUser!.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user =
        ref.watch(anyUserDataProvder(widget.video.userId));

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: _controller.value.isInitialized
                    ? SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowIcon = !isShowIcon;
                              });
                            },
                            child: Stack(
                              children: [
                                VideoPlayer(_controller),
                                if (isShowIcon) ...[
                                  Positioned(
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
                                  ),
                                  Positioned(
                                    right: 55,
                                    top: 94,
                                    child: GestureDetector(
                                      onTap: goForward,
                                      child: SizedBox(
                                        height: 50,
                                        child: Image.asset(
                                          'assets/images/go_back_final.png',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 48,
                                    top: 94,
                                    child: GestureDetector(
                                      onTap: goBackward,
                                      child: SizedBox(
                                        height: 50,
                                        child: Image.asset(
                                          'assets/images/go ahead final.png',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                        ),
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
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
                    child: user.when(
                      data: (userData) => Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                CachedNetworkImageProvider(userData.profilepic),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 5,
                            ),
                            child: Text(
                              userData.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 6, left: 6, bottom: 18),
                            child: Text(
                              userData.subscriptions.isEmpty
                                  ? "No subscriptions"
                                  : "${userData.subscriptions.length} subscriptions",
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
                                    onPressed: () async {
                                   await   ref
                                          .watch(subscribeRepositoryProvider)
                                          .subscribeToChannel(
                                              creatorUserId: userData.userId,
                                              userId: user.value!.userId,
                                              subscriptionList:
                                                 user.value!.subscriptions,);
                                    },
                                    colour: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      error: (error, stack) =>
                          Center(child: Text('Error: $error')),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
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
                                  onTap: likeVideo,
                                  child: Icon(
                                    Icons.thumb_up,
                                    size: 15.5,
                                    color: widget.video.likes.contains(
                                            FirebaseAuth
                                                .instance.currentUser!.uid)
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text("${widget.video.likes.length}"),
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => CommentSheet(
                        video: widget.video,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final AsyncValue<List<CommentModel>> comments =
                            ref.watch(
                          commentsProvider(widget.video.videoId),
                        );

                        return comments.when(
                          data: (commentList) {
                            if (commentList.isEmpty) {
                              return const SizedBox(height: 20);
                            }
                            return VideoFirstComment(
                              comments: commentList,
                              user: user.value!,
                              // Provide a default value
                            );
                          },
                          error: (error, stack) =>
                              Center(child: Text('Error: $error')),
                          loading: () => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 9,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("video")
                  .where("videoId", isNotEqualTo: widget.video.videoId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SliverToBoxAdapter(child: ErrorPage());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const SliverToBoxAdapter(child: Loader());
                }

                final videosMap = snapshot.data!.docs;
                final videos = videosMap
                    .map(
                      (video) => VideoModel.fromMap(
                          video.data() as Map<String, dynamic>),
                    )
                    .toList();

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Post(video: videos[index]);
                    },
                    childCount: videos.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
