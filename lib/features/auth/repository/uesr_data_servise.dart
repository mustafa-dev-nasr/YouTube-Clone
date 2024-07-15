import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataServiceProvider = Provider(
  (ref) => UesrDataServise(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class UesrDataServise {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  UesrDataServise({required this.auth, required this.firestore});
  addUesrDataToFirestore({
    required String desplayName,
    required String userName,
    required String email,
    required String profilepic,
    required String description,
  }) async {
    UserModel user = UserModel(
      desplayName: desplayName,
      userName: userName,
      email: email,
      profilepic: profilepic,
      subscriptions: [],
      videos: 0,
      userId: auth.currentUser!.uid,
      description: description,
      type: 'user',
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
  }

  Future<UserModel> fetchCurrentUserData() async {
    try {
      final currentUserMap =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      if (currentUserMap.exists) {
        UserModel user = UserModel.fromMap(currentUserMap.data()!);
        return user;
      } else {
        throw Exception('User does not exist');
      }
    } catch (e) {
      log('Error fetching user data: $e');
      rethrow;
    }
  }
   Future<UserModel> fetchAnyUserData(userId) async {
    try {
      final currentUserMap =
          await firestore.collection('users').doc(userId).get();
      if (currentUserMap.exists) {
        UserModel user = UserModel.fromMap(currentUserMap.data()!);
        return user;
      } else {
        throw Exception('User does not exist');
      }
    } catch (e) {
      log('Error fetching user data: $e');
      rethrow;
    }
  }
}
