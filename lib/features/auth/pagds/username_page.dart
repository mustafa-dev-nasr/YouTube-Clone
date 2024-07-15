import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/cores/widgets/flat_button.dart';
import 'package:flutter_application_1/features/auth/repository/uesr_data_servise.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formKey = GlobalKey<FormState>();

class UserNamePadge extends ConsumerStatefulWidget {
  final String desplayName;
  final String profilepic;
  final String email;

  const UserNamePadge(this.desplayName, this.profilepic, this.email,
      {super.key});

  @override
  ConsumerState<UserNamePadge> createState() => _UserNamePadgeState();
}

class _UserNamePadgeState extends ConsumerState<UserNamePadge> {
  bool isvalidate = true;
  final TextEditingController usernameController = TextEditingController();
  void ValidatrUsername() async {
    final usersMap = await FirebaseFirestore.instance.collection("Users").get();
    final users = usersMap.docs.map((user) => user).toList();
    String? targetedUsername;
    for (var user in users) {
      if (usernameController.text == user.data()["username"]) {
        targetedUsername = user.data()["username"];
        isvalidate = false;
        setState(() {});
      }
      if (usernameController.text != targetedUsername) {
        isvalidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 26),
            child: Text(
              'Enter the username',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Form(
              child: TextFormField(
                onChanged: (username) {
                  ValidatrUsername();
                },
                autovalidateMode: AutovalidateMode.always,
                validator: (username) {
                  return isvalidate ? null : "Username already taken";
                },
                controller: usernameController,
                key: formKey,
                decoration: InputDecoration(
                    hintText: 'Insert Username',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    suffixIcon: isvalidate
                        ? const Icon(Icons.verified_user_rounded)
                        : const Icon(Icons.cancel),
                    suffixIconColor: isvalidate ? Colors.green : Colors.red),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 8, right: 8),
            child: FlatButton(
                text: 'CONTINUO',
                onPressed: () {
                  //add user data in database
                  isvalidate
                      ? ref
                          .read(userDataServiceProvider)
                          .addUesrDataToFirestore(
                              desplayName: widget.desplayName,
                              userName: usernameController.text,
                              email: widget.email,
                              profilepic: widget.profilepic,
                              description: '')
                      : null;
                },
                colour: isvalidate ? Colors.green : Colors.green.shade100),
          )
        ],
      ),
    ));
  }
}
