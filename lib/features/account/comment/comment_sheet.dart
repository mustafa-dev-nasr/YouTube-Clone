import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/cores/screens/loader.dart';
import 'package:flutter_application_1/features/account/comment/comment_tile.dart';
import 'package:flutter_application_1/features/auth/provider/user_porvider.dart';
import 'package:flutter_application_1/features/upload/comment/comment_model.dart';
import 'package:flutter_application_1/features/upload/comment/comment_repository.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentSheet extends ConsumerStatefulWidget {
  final VideoModel video;
  const CommentSheet({required this.video, super.key});

  @override
  ConsumerState<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<CommentSheet> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).whenData((user) => user);
    return Container(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comment",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Icon(Icons.close)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.grey.shade400),
            child: const Text(
                "Remember to keep comments respctful and to follow our comment"),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("comments")
                .where("videoId", isEqualTo: widget.video.videoId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const ErrorPage();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }

              final commentMap = snapshot.data!.docs;
              final List<CommentModel> coments = commentMap
                  .map((comment) => CommentModel.fromMap(comment.data()))
                  .toList();
              return Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: coments.length,
                  itemBuilder: (context, index) {
                    return CommentTile(comment: coments[index]);
                  },
                ),
              );
            },
          ),
          const Spacer(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  backgroundImage: user.value != null
                      ? CachedNetworkImageProvider(user.value!.profilepic)
                      : null,
                ),
              ),
              SizedBox(
                height: 45,
                width: 275,
                child: TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      hintText: "Add a comment"),
                ),
              ),
              IconButton(
                  onPressed: () {
                    ref.watch(commentProvider).uploadCommentToFirestore(
                          commentText: commentController.text,
                          profilePic: user.value!.profilepic,
                          displayName: user.value!.desplayName,
                          videoId: widget.video.videoId,
                        );
                    commentController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    size: 35,
                    color: Colors.green,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
/*** StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("comments")
                .where("videoId", isEqualTo: widget.video.videoId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const ErrorPage();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              final commentsMap = snapshot.data!.docs;
              final List<CommentModel> comments = commentsMap
                  .map((comment) => CommentModel.fromMap(comment.data()))
                  .toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return CommentTile(
                      comment: comments[index],
                    );
                  },
                ),
              );
            },
          ), */