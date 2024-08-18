import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/account/accont_page.dart';
import 'package:flutter_application_1/features/channel/my_channel/pages/my_channel.dart';
import 'package:flutter_application_1/features/content/Long_video/long_video_screen.dart';
import 'package:flutter_application_1/features/content/short_video/padges/short_video_padge.dart';

List pages = [
  const LongVideoScreen(),
  const ShortVideoPage(),
  const Text(""),
  const MyChannel(),
];
