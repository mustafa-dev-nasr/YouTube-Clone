import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/auth/provider/user_porvider.dart';
import 'package:flutter_application_1/features/content/Long_video/parts/video.dart';
import 'package:flutter_application_1/features/content/Long_video/widgets/home_loder.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class Post extends ConsumerWidget {
  const Post({
    super.key,
    required this.video,
  });
  final VideoModel video;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel =
        ref.watch(anyUserDataProvder(video.userId));

    return userModel.when(
      data: (user) {
        // ignore: avoid_unnecessary_containers
        return Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Video(
                            video: video,
                          )));
            },
            child: Column(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                  imageUrl: video.thumbnail,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 5),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            CachedNetworkImageProvider(user.profilepic),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        video.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width * 0.12),
                  child: Row(
                    children: [
                      Text(
                        user.userName,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          video.views == 0
                              ? "No views"
                              : "${video.views.toString()} views",
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(
        child: HomeLoder(),
      ),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
