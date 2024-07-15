import 'dart:developer';

import 'package:flutter_application_1/features/auth/model/user_model.dart';
import 'package:flutter_application_1/features/auth/repository/uesr_data_servise.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.watch(userDataServiceProvider).fetchCurrentUserData();
  return user;
});
final anyUserDataProvder = FutureProvider.family((ref, userId) async {
  final UserModel user =
      await ref.watch(userDataServiceProvider).fetchAnyUserData(userId);
  return user;
});
