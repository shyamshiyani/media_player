import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player/utils/all_music_data.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final TextEditingController _searchController = TextEditingController();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  String? currentAudio;
  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.playlistAudioFinished.listen((event) {
      setState(() {
        isPlaying = false;
        currentAudio = null;
      });
    });
  }

  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  void playOrPause(String audioLink) {
    if (isPlaying && currentAudio == audioLink) {
      assetsAudioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      assetsAudioPlayer.open(Audio(audioLink),
          autoStart: true, showNotification: true);
      setState(() {
        isPlaying = true;
        currentAudio = audioLink;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xffD9D9D9),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_rounded,
                    color: Color(0xff489582),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "What do you want to listen to?",
                        hintStyle:
                            TextStyle(color: Color(0xffA1A1A1), fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Recommended Artist",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: 380,
            child: CarouselSlider(
              items: AllMusicData.allArtistData.map((e) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 300,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image(
                          image: NetworkImage("${e['ProfilePicture']}"),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 8,
                enlargeCenterPage: true,
                animateToClosest: true,
                viewportFraction: 0.8,
              ),
            ),
          ),
          const Text(
            "Trending Songs",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView(
              children: AllMusicData.allMusicData.map((e) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('audioDetailPage', arguments: e);
                  },
                  child: Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(e['Thumbnail']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e['SongName'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  e['ArtistName'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            playOrPause("${e['Path']}");
                          },
                          icon: Icon(
                            isPlaying && currentAudio == e['Path']
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
