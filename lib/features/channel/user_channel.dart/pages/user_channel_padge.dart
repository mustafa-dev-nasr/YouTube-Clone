import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/cores/widgets/flat_button.dart';

class UserCannelPage extends StatefulWidget {
  const UserCannelPage({super.key});

  @override
  State<UserCannelPage> createState() => _UserCannelPageState();
}

class _UserCannelPageState extends State<UserCannelPage> {
  bool haveVideo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/images/flutter background.png'),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'mustafa_magdy',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        '@mustafa',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.blueGrey),
                          children: [
                            TextSpan(text: 'No Subscription  '),
                            TextSpan(text: 'No Video  '),
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
            padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
            child: FlatButton(
                text: 'SUBSCRIBE', onPressed: () {}, colour: Colors.black),
          ),
          haveVideo
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.2),
                  child: const Center(
                    child: Text(
                      "No Video",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ),
                ),
        ],
      )),
    );
  }
}
