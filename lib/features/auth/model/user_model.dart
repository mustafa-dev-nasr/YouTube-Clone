import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String desplayName;
  final String userName;
  final String email;
  final String profilepic;
  final List<String> subscriptions;
  final int videos;
  final String userId;
  final String description;
  final String type;

  UserModel(
      {required this.desplayName,
      required this.userName,
      required this.email,
      required this.profilepic,
      required this.subscriptions,
      required this.videos,
      required this.userId,
      required this.description,
      required this.type});
  Map<String, dynamic> toMap() {
    return {
      'desplayName': desplayName,
      'userName': userName,
      'email': email,
      'profilepic': profilepic,
      'subscriptions': subscriptions,
      'videos': videos,
      'userId': userId,
      'description': description,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      desplayName: map['desplayName'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      profilepic: map['profilepic'] ?? '',
      subscriptions: List<String>.from(map['subscriptions'] ?? []),
      videos: map['videos'] ?? 0,
      userId: map['userId'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
    );
  }
}
