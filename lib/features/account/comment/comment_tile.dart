import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/features/upload/comment/comment_model.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        CachedNetworkImageProvider(comment.profilPic),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  comment.displayName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "a month ago",
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.sizeOf(context).width * 0.58),
            child: Expanded(child: Text(comment.commentText)),
          )
        ],
      ),
    );
  }
}
