import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/upload/comment/comment_model.dart';

class VideoFirstComment extends StatelessWidget {
  final List<CommentModel> comments;
  final UserModel user;

  const VideoFirstComment({
    Key? key,
    required this.comments,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox(); // Return an empty widget if there are no comments
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Comments",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16, // Adjusted font size for better readability
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "${comments.length}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16, // Adjusted font size for consistency
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(
                  user.profilepic,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  comments[0].commentText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Ensures text does not overflow
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}