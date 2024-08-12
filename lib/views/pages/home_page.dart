
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_player/views/pages/components/music_palyer.dart';
import 'package:media_player/views/pages/components/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isTapeed = false;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Media Booster"),
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: ("Music Player"),
                icon: Icon(
                  Icons.music_note_outlined,
                ),
              ),
              Tab(
                text: ("Video Player"),
                icon: Icon(
                  Icons.video_collection_outlined,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            Music(),
            VideoPlayer(),
          ],
        ));
  }
}
