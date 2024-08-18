import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscribeRepositoryProvider = Provider((ref) => SubscribeRepository(
      firestore: FirebaseFirestore.instance,
    ));

class SubscribeRepository {
  final FirebaseFirestore firestore;

  SubscribeRepository({required this.firestore});

  Future<void> subscribeToChannel({
    required String creatorUserId,
    required String userId,
    required List<String> subscriptionList,
  }) async {
    try {
      if (subscriptionList.contains(creatorUserId)) {
        await firestore.collection('users').doc(userId).update({
          'subscriptions': FieldValue.arrayRemove([creatorUserId]),
        });
      }
      if (!subscriptionList.contains(creatorUserId)) {
        await firestore.collection('users').doc(userId).update({
          'subscriptions': FieldValue.arrayUnion([creatorUserId]),
        });
      }
    } catch (e) {
      print('Error subscribing to channel: $e');
    }
  }
}
