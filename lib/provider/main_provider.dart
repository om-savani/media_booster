import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import '../model/music_model.dart';

class MainProvider with ChangeNotifier {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  // var for video
  String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  VideoPlayerController? videoController;
  ChewieController? chewieController;
  bool isVideoInitialized = false;

  // var for audio
  bool isPlaying = false;
  int currentIndex = 0;

  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;

  List<MusicModel> musicList = [
    MusicModel(
      title: 'Aayi nai',
      artist: "Pawan Singh,Sachin–Jigar",
      path: 'https://pagalfree.com/musics/128-Aayi Nai - Stree 2 128 Kbps.mp3',
      image:
          'https://c.saavncdn.com/256/Aayi-Nai-From-Stree-2-Hindi-2024-20240805153835-500x500.jpg',
    ),
    MusicModel(
      title: 'Bhul bhulaiyaa',
      artist: "Pitbull, Diljit Dosanjh",
      path:
          'https://pagalfree.com/musics/128-Bhool Bhulaiyaa 3 - Title Track (Feat. Pitbull) - Bhool Bhulaiyaa 3 128 Kbps.mp3',
      image:
          'https://c.saavncdn.com/192/Bhool-Bhulaiyaa-3-Title-Track-Feat-Pitbull-Hindi-2024-20241016191004-500x500.jpg',
    ),
    MusicModel(
      title: 'Angaaron',
      artist: "Shreya Ghoshal",
      path:
          'https://pagalfree.com/musics/128-Angaaron - Pushpa 2 The Rule 128 Kbps.mp3',
      image:
          'https://c.saavncdn.com/580/Angaaron-From-Pushpa-2-The-Rule-Hindi-2024-20240528221027-500x500.jpg',
    ),
    MusicModel(
      title: 'Lutt Putt Gaya',
      artist: "Arijit Singh",
      path:
          'https://pagalfree.com/musics/128-Lutt Putt Gaya - Dunki 128 Kbps.mp3',
      image:
          'https://c.saavncdn.com/265/Lutt-Putt-Gaya-From-Dunki-Hindi-2023-20231211171015-500x500.jpg',
    ),
    MusicModel(
      title: 'Matargashti',
      artist: "Mohit Chauhan",
      path:
          'https://pagalfree.com/musics/128-Matargashti - Tamasha 128 Kbps.mp3',
      image: 'https://i1.sndcdn.com/artworks-000136876861-nr231r-t500x500.jpg',
    ),
    MusicModel(
      title: 'Mast Magan',
      artist: "Arijit Singh",
      path:
          'https://pagalfree.com/musics/128-Mast Magan - 2 States 128 Kbps.mp3',
      image: 'https://upload.wikimedia.org/wikipedia/en/b/b1/Mast_Magan.jpg',
    ),
    MusicModel(
      title: 'Ishq Di Baajiyaan',
      artist: "Diljit Dosanjh, Shankar–Ehsaan–Loy",
      path:
          'https://pagalfree.com/musics/128-Ishq Di Baajiyaan - Soorma 128 Kbps.mp3',
      image:
          'https://c.saavncdn.com/193/Soorma-Hindi-2018-20180702111043-500x500.jpg',
    ),
    MusicModel(
      title: 'Ilahi',
      artist: "Arijit Singh",
      path:
          'https://pagalfree.com/musics/128-Ilahi - Yeh Jawaani Hai Deewani 128 Kbps.mp3',
      image: 'https://i1.sndcdn.com/artworks-000394974879-tuburz-t500x500.jpg',
    ),
    MusicModel(
      title: 'Pichkari',
      artist: "Shalmali Kholgade, Amitabh Bhattacharya",
      path:
          'https://pagalfree.com/musics/128-Balam Pichkari - Yeh Jawaani Hai Deewani 128 Kbps.mp3',
      image: 'https://images.filmibeat.com/img/2013/04/12-1365760658-b-5.jpg',
    ),
    MusicModel(
      title: 'London Thumakda',
      artist: "Sonu Kakkar, Neha Kakkar, Amit Trivedi,",
      path:
          'https://pagalfree.com/musics/128-London Thumakda - Queen 128 Kbps.mp3',
      image: 'https://c.saavncdn.com/125/Queen-2014-500x500.jpg',
    ),
    MusicModel(
      title: 'Ranjha',
      artist: "B Praak, Romy and Anvita Dutt Guptan",
      path:
          'https://pagalfree.com/musics/128-Ranjha (Queen) - Queen 128 Kbps.mp3',
      image:
          'https://c.saavncdn.com/264/Ranjha-From-Shershaah--Hindi-2021-20210804173407-500x500.jpg',
    ),
  ];

  MainProvider() {
    initListen();
    initVideo();
  }

  // Audio methods
  void initListen() {
    audioPlayer.currentPosition.listen((position) {
      currentDuration = position;
      notifyListeners();
    });

    audioPlayer.current.listen((playing) {
      totalDuration = playing?.audio.duration ?? Duration.zero;
      notifyListeners();
    });
  }

  void playOrPause() {
    audioPlayer.playOrPause();
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void playSong(int index) {
    currentIndex = index;
    audioPlayer.open(
      Audio.network(musicList[index].path!),
      showNotification: true,
    );
    isPlaying = true;
    notifyListeners();
  }

  void nextSong() {
    currentIndex = (currentIndex + 1) % musicList.length;
    playSong(currentIndex);
    notifyListeners();
  }

  void previousSong() {
    currentIndex = (currentIndex - 1 + musicList.length) % musicList.length;
    playSong(currentIndex);
    notifyListeners();
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
    notifyListeners();
  }

  void pauseSong() {
    audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  // Video methods
  Future<void> initVideo() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController!,
      autoPlay: false,
      looping: true,
    );
    isVideoInitialized = true;
    notifyListeners();
  }

  void playOrPauseVideo() {
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
    notifyListeners();
  }

  void disposeVideo() {
    videoController?.dispose();
    chewieController?.dispose();
    isVideoInitialized = false;
    notifyListeners();
  }
}
