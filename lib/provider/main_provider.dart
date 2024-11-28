import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import '../model/music_model.dart';

class MainProvider with ChangeNotifier {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  VideoPlayerController? controller;
  ChewieController? chewieController;
  bool isPlaying = false;
  int currentIndex = 0;

  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;

  List<MusicModel> musicList = [
    MusicModel(
      title: 'Singham Again Title Track',
      path:
          'https://pagalfree.com/musics/128-Singham Again Title Track - Singham Again 128 Kbps.mp3',
      image:
          "https://pagalfree.com/images/128Singham%20Again%20Title%20Track%20-%20Singham%20Again%20128%20Kbps.jpg",
    ),
    MusicModel(
      title: 'Bhool Bhulaiyaa 3',
      path:
          "https://pagalfree.com/musics/128-Bhool Bhulaiyaa 3 - Title Track (Feat. Pitbull) - Bhool Bhulaiyaa 3 128 Kbps.mp3",
      image:
          "https://pagalfree.com/images/128Bhool%20Bhulaiyaa%203%20-%20Title%20Track%20(Feat.%20Pitbull)%20-%20Bhool%20Bhulaiyaa%203%20128%20Kbps.jpg",
    ),
    MusicModel(
      title: 'Pushpa Pushpa',
      path:
          'https://pagalfree.com/musics/128-Pushpa Pushpa - Pushpa 2 The Rule 128 Kbps.mp3',
      image:
          "https://pagalfree.com/images/128Pushpa%20Pushpa%20-%20Pushpa%202%20The%20Rule%20128%20Kbps.jpg",
    ),
  ];

  List<String> musicListUrl = [
    "https://pagalfree.com/images/128Singham%20Again%20Title%20Track%20-%20Singham%20Again%20128%20Kbps.jpg",
    "https://pagalfree.com/images/128Bhool%20Bhulaiyaa%203%20-%20Title%20Track%20(Feat.%20Pitbull)%20-%20Bhool%20Bhulaiyaa%203%20128%20Kbps.jpg",
    "https://pagalfree.com/images/128Pushpa%20Pushpa%20-%20Pushpa%202%20The%20Rule%20128%20Kbps.jpg",
  ];

  MainProvider() {
    initListeners();
  }

  void initListeners() {
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
      // autoStart: true,
      showNotification: true,
    );
    isPlaying = true;
    notifyListeners();
  }

  void nextSong() {
    currentIndex = (currentIndex + 1) % musicList.length;
    playSong(currentIndex);
  }

  void previousSong() {
    currentIndex = (currentIndex - 1 + musicList.length) % musicList.length;
    playSong(currentIndex);
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

  Future<void> init() async {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    );
    await controller!.initialize();
    chewieController = ChewieController(
      videoPlayerController: controller!,
      autoPlay: true,
      looping: true,
    );
    notifyListeners();
  }

  void playOrPauseVideo() {
    if (controller!.value.isPlaying) {
      controller!.pause();
    } else {
      controller!.play();
    }
    notifyListeners();
  }

  // void changeIndex(int index) {
  //   pageIndex = index;
  //   notifyListeners();
  // }
}
