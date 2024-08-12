class Song {
  String name;
  String song;
  String img;
  String video;
  Song({
    required this.name,
    required this.song,
    required this.img,
    required this.video,
  });

  static List<Song> songs = [
    Song(
      name: "Satranga",
      song: "assets/music/satranga.m4a",
      img: "assets/img/Satranga.jpg",
      video: "assets/video/SATRANGA.mp4",
    ),
    Song(
      name: "Apna Bana Le",
      song: "assets/music/apna_banale.mp3",
      img: "assets/img/apna_banale.jpg",
      video: "assets/video/Apna Bana Le.mp4",
    ),
    Song(
      name: "Chogada",
      song: "assets/music/Chogada.m4a",
      img: "assets/img/Chogada.jpeg",
      video: "assets/video/Chogada.mp4",
    ),
    Song(
      name: "Daayre",
      song: "assets/music/Daayre.m4a",
      img: "assets/img/DAAYRE.jpeg",
      video: "assets/video/Daayre.mp4",
    ),
    Song(
      name: "Deva Deva",
      song: "assets/music/Deva Deva.m4a",
      img: "assets/img/Deva-Deva.jpg",
      video: "assets/video/Deva Deva.mp4",
    ),
    Song(
      name: "Dhokha Dhadi",
      song: "assets/music/Dhokha Dhadi.m4a",
      img: "assets/img/Dhokha Dhadi.jpg",
      video: "assets/video/Dhokha Dhadi.mp4",
    ),
    Song(
      name: "Kesriyo Rang",
      song: "assets/music/Kesriyo Rang.m4a",
      img: "assets/img/Kesariyo_Rang.jpg",
      video: "assets/video/Kesariyo Rang.mp4",
    ),
    Song(
      name: "Saware",
      song: "assets/music/Saware.m4a",
      img: "assets/img/saware.jpg",
      video: "assets/video/Saware.mp4",
    ),
    Song(
      name: "Tane Joyi Me",
      song: "assets/music/Tane Joyi Me.m4a",
      img: "assets/img/tane_joi_me.jpg",
      video: "assets/video/Tane joi me Jyar Thi.mp4",
    ),
  ];
}
