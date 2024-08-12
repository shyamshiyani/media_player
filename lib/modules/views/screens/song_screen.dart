import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_player/modules/views/screens/video_screen.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../../models/song_model.dart';
import '../components/audio/seekbar.dart';

class SongScreen extends StatefulWidget {
  final int songIndex;
  final List<Song> songList;
  const SongScreen(
      {super.key, required this.songIndex, required this.songList});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${widget.songList[widget.songIndex].song}'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekbarData> get seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekbarData>(
        audioPlayer.positionStream,
        audioPlayer.durationStream,
        (Duration position, Duration? duration) {
          return SeekbarData(
            position: position,
            duration: duration ?? Duration.zero,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Music",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 270,
                        width: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          widget.songList[widget.songIndex].img,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoScreen(
                                videoUrl:
                                    widget.songList[widget.songIndex].video,
                              ),
                            ),
                          );
                        },
                        iconSize: 60,
                        // play_circle
                        icon: Icon(
                          Icons.slow_motion_video,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.songList[widget.songIndex].name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20),
                // SeekBar...........
                StreamBuilder<SeekbarData>(
                  stream: seekBarDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return SeekBar(
                      position: positionData?.position ?? Duration.zero,
                      duration: positionData?.duration ?? Duration.zero,
                      onChanged: audioPlayer.seek,
                    );
                  },
                ),
                // Buttons.......................
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // skip_previous :-
                    StreamBuilder<SequenceState?>(
                      stream: audioPlayer.sequenceStateStream,
                      builder: (context, index) {
                        return IconButton(
                          onPressed: () {
                            if (widget.songIndex > 0) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SongScreen(
                                    songIndex: widget.songIndex - 1,
                                    songList: widget.songList,
                                  ),
                                ),
                              );
                            }
                          },
                          iconSize: 40,
                          // skip_previous_rounded
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    // Play / Pause :-
                    StreamBuilder<PlayerState>(
                      stream: audioPlayer.playerStateStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final playersState = snapshot.data;
                          final processingState =
                              (playersState! as PlayerState).processingState;
                          if (processingState == ProcessingState.loading ||
                              processingState == ProcessingState.buffering) {
                            return Container(
                              width: 64.0,
                              height: 64.0,
                              margin: const EdgeInsets.all(10),
                              child: const CircularProgressIndicator(),
                            );
                          } else if (!audioPlayer.playing) {
                            return IconButton(
                              onPressed: () {
                                audioPlayer.play();
                              },
                              iconSize: 60,
                              // play_circle
                              icon: const Icon(
                                Icons.play_circle,
                                color: Colors.white,
                              ),
                            );
                          } else if (processingState !=
                              ProcessingState.completed) {
                            return IconButton(
                              onPressed: audioPlayer.pause,
                              iconSize: 60,
                              // pause_circle
                              icon: const Icon(
                                Icons.pause_circle,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return IconButton(
                              onPressed: () => audioPlayer.seek(
                                Duration.zero,
                                index: audioPlayer.effectiveIndices!.first,
                              ),
                              iconSize: 60,
                              // replay_circle_filled_rounded
                              icon: const Icon(
                                Icons.replay_circle_filled_rounded,
                                color: Colors.white,
                              ),
                            );
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    // skip_next :-
                    StreamBuilder<SequenceState?>(
                      stream: audioPlayer.sequenceStateStream,
                      builder: (context, index) {
                        return IconButton(
                          onPressed: () {
                            if (widget.songIndex < widget.songList.length - 1) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SongScreen(
                                    songIndex: widget.songIndex + 1,
                                    songList: widget.songList,
                                  ),
                                ),
                              );
                            }
                          },
                          iconSize: 40,
                          // skip_next
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
