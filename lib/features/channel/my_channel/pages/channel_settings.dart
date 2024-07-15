import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cores/screens/error_page.dart';
import 'package:flutter_application_1/features/auth/provider/user_porvider.dart';
import 'package:flutter_application_1/features/channel/edit_setting_dialog.dart';
import 'package:flutter_application_1/features/channel/my_channel/repository/edit_fiel.dart';
import 'package:flutter_application_1/features/channel/setting_field_item.dart';
import 'package:flutter_application_1/widgets/home_padge_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChannelSettings extends ConsumerStatefulWidget {
  const ChannelSettings({super.key});

  @override
  ConsumerState<ChannelSettings> createState() => _ChannelSettingsState();
}

class _ChannelSettingsState extends ConsumerState<ChannelSettings> {
  bool isSwiched = false;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
        data: (currenUser) => Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 170,
                          child: Image.asset(
                            "assets/images/flutter background.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 165,
                          top: 60,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blueGrey,
                            backgroundImage: CachedNetworkImageProvider(
                                currenUser.profilepic),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 16,
                          child: Image.asset(
                            'assets/icons/camera.png',
                            height: 34,
                            color: Colors.white,
                          ),
                        ),
                        //SECOND PART
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                        identifier: "Name",
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => SettingsDialog(
                                    identifier: 'your new name',
                                    onSave: (name) {
                                      ref
                                          .watch(editSettingesFildProvider)
                                          .editDisplayName(name);
                                    },
                                  ));
                        },
                        value: currenUser.desplayName),
                    const SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                        identifier: "Handel",
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => SettingsDialog(
                                    identifier: 'your new userName',
                                    onSave: (userName) {
                                      ref
                                          .watch(editSettingesFildProvider)
                                          .editUserName(userName);
                                    },
                                  ));
                        },
                        value: currenUser.userName),
                    const SizedBox(
                      height: 14,
                    ),
                    SettingsItem(
                        identifier: "Discrption",
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => SettingsDialog(
                                    identifier: 'your new discrption',
                                    onSave: (description) {
                                      ref
                                          .watch(editSettingesFildProvider)
                                          .editDiscrption(description);
                                    },
                                  ));
                        },
                        value: currenUser.description),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Keep all my subscribels private"),
                          Switch(
                              value: isSwiched,
                              onChanged: (valuo) {
                                isSwiched = valuo;
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Text(
                        '''Changes made no yor names and profile are visible only  to youtub and other Google Services''',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    )
                  ],
                ),
              )),
            ),
        error: (error, stackTrace) => const ErrorPage(),
        loading: () => const HomePageLodoar());
  }
}
