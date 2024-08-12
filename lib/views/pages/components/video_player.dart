import 'package:flutter/material.dart';
import 'package:media_player/utils/all_video_data.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  AllVideoData allVideoData = AllVideoData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: AllVideoData.allVideoData.map((e) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 100,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('videoDetailPage', arguments: e);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 100, // Adjusted height
                        width: 180, // Adjusted width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage("${e['Thumbnail']}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${e['VideoName']}',
                          style: TextStyle(
                            color: Color(0xFF0A0A0A),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Text(
                          '${e['SingersName']}',
                          style: TextStyle(
                            color: Color(0xFF6C6C6C),
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Text(
                          'Views:${e['Views']}',
                          style: TextStyle(
                            color: Color(0xFF6C6C6C),
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        }).toList(),
      ),
    );
  }
}
