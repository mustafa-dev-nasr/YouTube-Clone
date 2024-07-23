import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShortLodor extends StatelessWidget {
  const ShortLodor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.vertical, // Scroll vertically

        itemCount: 3,
        itemBuilder: (context, index) => SizedBox(
              width: double.infinity,
              height: double.infinity,
              child:
                  // Video Player
                  PageView.builder(
                scrollDirection: Axis.vertical, // Scroll vertically

                itemCount: 3,
                itemBuilder: (context, index) => Stack(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[500]!,
                      highlightColor: Colors.grey[300]!,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height,
                        color: const Color.fromARGB(255, 75, 26, 26),
                      ),
                    ),
                    // Video overlay UI elements
                    Positioned(
                      bottom: MediaQuery.sizeOf(context).height / 4,
                      right: 10,
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
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: const Icon(Icons.favorite,
                                          color: Colors.white)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: const Icon(Icons.comment,
                                          color: Colors.white)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: const Icon(Icons.share,
                                          color: Colors.white)),

                                  // User info
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 8,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child:
                                      Icon(Icons.person, color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey,
                                  ),
                                  height: 20,
                                  width: 200,
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
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey,
                            ),
                            height: 20,
                            width: 300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
