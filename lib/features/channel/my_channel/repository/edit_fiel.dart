import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editSettingesFildProvider = Provider((ref) => EditSettingesFild(
    firestor: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class EditSettingesFild {
  final FirebaseFirestore firestor;
  final FirebaseAuth auth;

  EditSettingesFild({required this.firestor, required this.auth});
  editDisplayName(desplayName) async {
    await firestor.collection("users").doc(auth.currentUser!.uid).update(
          ({
            "desplayName": desplayName,
          }),
        );
  }

  editUserName(userName) async {
    await firestor.collection("users").doc(auth.currentUser!.uid).update(
          ({
            "userName": userName,
          }),
        );
  }

  editDiscrption(description) async {
    await firestor.collection("users").doc(auth.currentUser!.uid).update(
          ({
            "description": description,
          }),
        );
  }
}
