import 'package:flutter/material.dart';

class AudioDetailPage extends StatefulWidget {
  const AudioDetailPage({super.key});

  @override
  State<AudioDetailPage> createState() => _AudioDetailPageState();
}

class _AudioDetailPageState extends State<AudioDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage("https://picsum.photos/380/380"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                "Song Name",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                width: 96,
                height: 18,
                child: Text(
                  'The Beatles',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 16,
                  ),
                ),
              ),
              Slider(
                value: 0.5,
                onChanged: (val) {},
                min: 0,
                max: 1,
              ),
              Text("00:00:00/00:00:00"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      size: 45,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      size: 45,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.skip_next_rounded,
                        size: 45,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
