import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: Colors.grey,
          backgroundImage: CachedNetworkImageProvider(userModel.profilepic),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 4),
          child: Text(
            userModel.userName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.blueGrey),
              children: [
                TextSpan(text: '${userModel.userName}   '),
                TextSpan(
                    text: '${userModel.subscriptions.length} Subscribtion   '),
                TextSpan(text: '${userModel.videos} Videis   '),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
