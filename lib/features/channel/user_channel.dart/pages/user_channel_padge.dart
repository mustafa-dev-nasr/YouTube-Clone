import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/cores/screens/loader.dart';
import 'package:flutter_application_1/cores/widgets/flat_button.dart';
import 'package:flutter_application_1/features/auth/provider/user_porvider.dart';
import 'package:flutter_application_1/features/channel/provider/channel_provider.dart';
import 'package:flutter_application_1/features/content/Long_video/parts/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCannelPage extends StatefulWidget {
  final String userId;
  const UserCannelPage({super.key, required this.userId});

  @override
  State<UserCannelPage> createState() => _UserCannelPageState();
}

class _UserCannelPageState extends State<UserCannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Consumer(
                builder: (context, ref, child) {
                  return ref.watch(anyUserDataProvder(widget.userId)).when(
                        data: (data) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    height: 250,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/flutter background.png',
                                            ),
                                            fit: BoxFit.fill)),
                                    child: IconButton.outlined(
                                        color: Colors.blueGrey,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ))),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 12, right: 12),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 38,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: CachedNetworkImageProvider(
                                        data.profilepic),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            SizedBox(
                                              width: 280,
                                              child: Text(
                                                data.userName,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "@${data.desplayName}",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blueGrey),
                                        ),
                                        const SizedBox(height: 5),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.blueGrey),
                                            children: [
                                              TextSpan(
                                                  text: data
                                                      .subscriptions.length
                                                      .toString()),
                                              TextSpan(
                                                  text: data.videos.toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 8, right: 8, bottom: 8),
                              child: FlatButton(
                                  text: 'SUBSCRIBE',
                                  onPressed: () {},
                                  colour: Colors.black),
                            ),
                          ],
                        ),
                        error: (error, stackTrace) => const ErrorPage(),
                        loading: () => const Loader(),
                      );
                },
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(eachCannaleProvider(widget.userId)).when(
                      data: (videoList) {
                        if (videoList.isEmpty) {
                          return const SliverToBoxAdapter(
                              child: Center(child: Text('No videos found.')));
                        } else {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Post(video: videoList[index]);
                              },
                              childCount: videoList.length,
                            ),
                          );
                        }
                      },
                      loading: () => const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator())),
                      error: (error, stackTrace) => SliverToBoxAdapter(
                          child: Center(child: Text('Error: $error'))),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
