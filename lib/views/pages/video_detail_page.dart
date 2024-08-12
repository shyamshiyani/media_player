import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> allVideoData = ModalRoute.of(context)!
        .settings
        .arguments as List<Map<String, dynamic>>;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("VideoPlayer"),
      ),
      body: Center(
        child: Text(
          "$allVideoData)",
        ),
      ),
    );
  }
}
