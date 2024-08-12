import 'package:flutter/material.dart';
import 'package:media_player/views/pages/detail_page.dart';
import 'package:media_player/views/pages/home_page.dart';
import 'package:media_player/views/pages/video_detail_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'audioDetailPage': (context) => const AudioDetailPage(),
        'videoDetailPage': (context) => const VideoDetailPage(),
      },
    ),
  );
}
