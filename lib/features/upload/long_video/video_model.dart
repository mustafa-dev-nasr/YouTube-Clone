// VideoModel class
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String videoUrl;
  final String thumbnail;
  final String title;
  final String description;
  final DateTime datePublished;
  final int views;
  final String videoId;
  final String userId;
  final String type;
  final List likes;

  VideoModel({
    required this.description,
    required this.videoUrl,
    required this.thumbnail,
    required this.title,
    required this.datePublished,
    required this.views,
    required this.videoId,
    required this.userId,
    required this.type,
    required this.likes,
  });

  // Convert a VideoModel object into a Map
  Map<String, dynamic> toMap() {
    return {
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'title': title,
      'description': description,
      'datePublished': datePublished,
      'views': views,
      'videoId': videoId,
      'userId': userId,
      'type': type,
      'likes': likes,
    };
  }

  // Create a VideoModel object from a Map
  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      videoUrl: map['videoUrl'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      title: map['title'] ?? '',
      datePublished: map['datePublished'] is Timestamp
          ? (map['datePublished'] as Timestamp).toDate()
          : DateTime.now(), // Provide a default value or handle as needed
      views: map['views'] ?? 0,
      videoId: map['videoId'] ?? '',
      userId: map['userId'] ?? '',
      type: map['type'] ?? '',
      likes: List<String>.from(map['likes'] ?? []),
      description: map['description'] ?? '',
    );
  }
}
