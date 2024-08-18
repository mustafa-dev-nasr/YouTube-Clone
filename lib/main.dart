import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/features/auth/pagds/login_page.dart';
import 'package:flutter_application_1/features/channel/my_channel/pages/channel_settings.dart';
import 'package:flutter_application_1/features/channel/my_channel/pages/my_channel.dart';
import 'package:flutter_application_1/features/auth/pagds/username_page.dart';
import 'package:flutter_application_1/features/channel/user_channel.dart/pages/user_channel_padge.dart';
import 'package:flutter_application_1/features/upload/long_video/video_details_page.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/widgets/home_padge_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const HomePageLodoar();
          }

          if (!authSnapshot.hasData || authSnapshot.data == null) {
            return const LoginPage();
          }

          final user = authSnapshot.data;
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(user!.uid)
                .snapshots(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const HomePageLodoar();
              }

              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                return UserNamePadge(
                  user.displayName ?? 'No Name',
                  user.photoURL ?? 'No Photo URL',
                  user.email ?? 'No Email',
                );
              }

              return const HomePage();
            },
          );
        },
      ),
    );
  }
}
