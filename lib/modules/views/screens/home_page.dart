import 'package:flutter/material.dart';
import 'package:media_player/modules/views/screens/song_screen.dart';

import '../../models/song_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Song> song = Song.songs;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0,
        leading: const Image(
          image: AssetImage(
            'assets/img/logo.png',
          ),
          fit: BoxFit.cover,
        ),
        title: const Text(
          "Music",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: song.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongScreen(
                      songIndex: index,
                      songList: Song.songs,
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.only(left: 5),
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          song[index].img,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          song[index].name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
