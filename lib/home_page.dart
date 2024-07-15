import 'dart:developer';
import 'package:flutter_application_1/features/account/accont_page.dart';
import 'package:flutter_application_1/features/content/bottom_navigation.dart';
import 'package:flutter_application_1/features/upload/upload_bottom_sheet.dart';
import 'package:flutter_application_1/pages/pages_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/cores/screens/loader.dart';
import 'package:flutter_application_1/cores/widgets/image_button.dart';
import 'package:flutter_application_1/features/auth/provider/user_porvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currnetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/youtube.jpg",
                  height: 36,
                ),
                const SizedBox(width: 4),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 42,
                    child: ImageButton(
                      image: "cast.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ImageButton(
                    image: "notification.png",
                    onPressed: () {},
                    haveColor: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 15),
                  child: SizedBox(
                    height: 41.5,
                    child: ImageButton(
                      image: "search.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(currentUserProvider).when(
                        data: (currentUser) => Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccontPage(user: currentUser,)));
                                },
                                child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      currentUser.profilepic),
                                  backgroundColor: Colors.grey,
                                  radius: 15,
                                ),
                              ),
                            ),
                        error: (error, stackTrace) {
                          log('Error: $error');
                          return const ErrorPage();
                        },
                        loading: () => Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.white,
                              child: const ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(right: 3),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 15,
                                  ),
                                ),
                              ),
                            ));
                  },
                )
              ],
            ),
            Expanded(child: (pages[currnetIndex]))
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          onpreseed: (int index) {
            if (index != 2) {
              currnetIndex = index;
              setState(() {});
            } else {
              showModalBottomSheet(
                context: context,
                builder: (context) => const CreateBottomSheet(),
              );
            }
          },
        ),
      ),
    );
  }
}