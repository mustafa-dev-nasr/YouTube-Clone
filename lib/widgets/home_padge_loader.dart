import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/widgets/image_button.dart';
import 'package:shimmer/shimmer.dart';

class HomePageLodoar extends StatelessWidget {
  const HomePageLodoar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 130,
                      height: 36,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(9)),
                      // child: Image.asset(
                      //   "assets/images/youtube.jpg",
                      // ),
                    )),
                const SizedBox(width: 4),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: SizedBox(
                      height: 42,
                      child: ImageButton(
                        image: "cast.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: SizedBox(
                    height: 38,
                    child: ImageButton(
                      image: "notification.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 15),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: SizedBox(
                      height: 41.5,
                      child: ImageButton(
                        image: "search.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
