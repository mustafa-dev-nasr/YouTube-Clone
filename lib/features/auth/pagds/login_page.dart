import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/repository/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Image.asset(
                'assets/images/youtube-signin.jpg',
                height: 150,
              ),
            ),
            const Text(
              "Welcom To YouTube",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async{
             await   ref.read(authServiceProvider).signInWithGoogle();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 55),
                child: Image.asset(
                  'assets/images/signinwithgoogle.png',
                  height: 60,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
