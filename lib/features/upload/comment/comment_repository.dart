import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_application_1/features/upload/comment/comment_model.dart';

// Define a provider for the upload function
final uploadCommentProvider = Provider((ref) => CommentRepository(firestore: FirebaseFirestore.instance));

class CommentRepository {
  final FirebaseFirestore firestore;

  CommentRepository({required this.firestore});
  void uploadCommentToFirestore({
  required String commentText,
  required String profilPic,
  required String displayName,
}) async {
  String commentId = const Uuid().v4();
  CommentModel comment = CommentModel(
    commentText: commentText,
    videoId: commentId, // Assuming videoId is same as commentId for now
    commentId: commentId,
    profilPic: profilPic,
    displayName: displayName,
  );

  await FirebaseFirestore.instance
      .collection('comments')
      .doc(commentId)
      .set(comment.toMap());
}

}

