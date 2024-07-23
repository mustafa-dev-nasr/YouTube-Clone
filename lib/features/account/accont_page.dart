import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/account/items.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/channel/my_channel/pages/my_channel.dart';

class AccontPage extends StatelessWidget {
  const AccontPage({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyChannel()));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton.outlined(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
          ),
          CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(user.profilepic),
            backgroundColor: Colors.blueGrey,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              user.userName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "@${user.desplayName}",
              style: const TextStyle(fontSize: 24, color: Colors.blueGrey),
            ),
          ),
          const Items()
        ],
      ),
    )));
  }
}
