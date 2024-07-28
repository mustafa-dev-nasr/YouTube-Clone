import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/upload/comment/comment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentsProvider =
    FutureProvider.family<List<CommentModel>, String>((ref, videoId) async {
  try {
    final commentsQuerySnapshot = await FirebaseFirestore.instance
        .collection("comments")
        .where("videoId", isEqualTo: videoId) // Replace with an actual ID
        .get();

    print('Query returned ${commentsQuerySnapshot.docs.length} documents');

    // Print document data
    for (var doc in commentsQuerySnapshot.docs) {
      print('Document data: ${doc.data()}');
    }

    final List<CommentModel> comments = commentsQuerySnapshot.docs
        .map((doc) => CommentModel.fromMap(doc.data()))
        .toList();

    print('Parsed ${comments.length} comments');
    return comments;
  } catch (e) {
    print('Error fetching comments: $e');
    throw Exception('Failed to load comments: $e');
  }
});
