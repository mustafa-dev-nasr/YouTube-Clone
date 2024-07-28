import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/features/auth/provider/user_porvider.dart';
import 'package:flutter_application_1/features/channel/my_channel/parts/bottons_widdget_coustom.dart';
import 'package:flutter_application_1/features/channel/my_channel/parts/tab_bar.dart';
import 'package:flutter_application_1/features/channel/my_channel/parts/tab_padge.dart';
import 'package:flutter_application_1/features/channel/my_channel/parts/top_header.dart';
import 'package:flutter_application_1/widgets/home_padge_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyChannel extends ConsumerWidget {
  const MyChannel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) => Scaffold(
            body: SafeArea(
                child: DefaultTabController(
              length: 7,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TopHeader(
                        userModel: currentUser,
                      ),
                      const Text(
                        "more about tshis channel",
                        style: TextStyle(color: Colors.blue),
                      ),
                      const ButtonsWidgetCustom(),
                      const PageTBar(),
                      const TabPadge(),
                    ],
                  ),
                ),
              ),
            )),
          ),
          error: (error, stackTrace) {
            log('Error: $error');
            return const ErrorPage();
          },
          loading: () => const HomePageLodoar(),
        );
  }
}
