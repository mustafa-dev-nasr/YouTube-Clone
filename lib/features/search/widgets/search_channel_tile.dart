import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/widgets/flat_button.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/channel/user_channel.dart/pages/user_channel_padge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../channel/my_channel/repository/subscribe_respository.dart';

class SearchChannelTile extends ConsumerWidget {
  final UserModel user;
  const SearchChannelTile({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserCannelPage(userId: user.userId)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(user.profilepic),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45),
              child: Column(
                children: [
                  Text(
                    user.userName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "@${user.desplayName}",
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    user.subscriptions.length.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: FlatButton(
                        text: "Subscribe",
                        onPressed: ()  async {
                                   await   ref
                                          .watch(subscribeRepositoryProvider)
                                          .subscribeToChannel(
                                              creatorUserId:  FirebaseAuth.instance.currentUser!.uid,
                                              userId: user.userId,
                                              subscriptionList:
                                                 user.subscriptions);
                                    },
                        colour: Colors.black),
                  )
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
