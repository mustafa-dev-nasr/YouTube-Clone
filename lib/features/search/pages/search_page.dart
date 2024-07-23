import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/content/Long_video/parts/post.dart';
import 'package:flutter_application_1/features/search/providers/search_provider.dart';
import 'package:flutter_application_1/features/search/widgets/search_channel_tile.dart';
import 'package:flutter_application_1/features/upload/long_video/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  List<dynamic> foundItems =
      []; // Use dynamic or a more specific type if possible

  Future<void> filterList(String keywordSelected) async {
    List<dynamic> result = [];
    List<UserModel> users = await ref.watch(allCanalProvider);
    List<VideoModel> videos = await ref.watch(allVideoProvider);

    // Filter the list based on the keywordSelected
    final foundChannels = users.where((user) {
      return user.desplayName
          .toString()
          .toLowerCase()
          .contains(keywordSelected.toLowerCase());
    }).toList();

    final foundVideos = videos.where((video) {
      return video.title
          .toString()
          .toLowerCase()
          .contains(keywordSelected.toLowerCase());
    }).toList();

    result.addAll(foundChannels);
    result.addAll(foundVideos);

    setState(() {
      result.shuffle();
      foundItems = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.sizeOf(context).width * .85,
                    child: TextFormField(
                      onChanged: (value) async {
                        await filterList(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search YouTube',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: foundItems.isEmpty
                    ? const Center(child: Text('No results found'))
                    : ListView.builder(
                        itemCount: foundItems.length,
                        itemBuilder: (context, index) {
                          final selectedItem = foundItems[index];
                          if (selectedItem is VideoModel) {
                            return Post(video: selectedItem);
                          } else if (selectedItem is UserModel) {
                            return SearchChannelTile(
                              user: selectedItem,
                            );
                          } else {
                            return const SizedBox(); // Add a default widget if needed
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
