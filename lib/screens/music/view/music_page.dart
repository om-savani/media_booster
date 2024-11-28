import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_booster/model/music_model.dart';
import 'package:provider/provider.dart';

import '../../../provider/main_provider.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MainProvider>();
    final read = context.read<MainProvider>();
    MusicModel model = ModalRoute.of(context)!.settings.arguments as MusicModel;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            read.pauseSong();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
        title: const Text('Now Playing'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Now Playing Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: model.image ?? "",
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  model.title ?? "Unknown Title",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  model.artist ?? "Unknown Artist",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "${formatDuration(watch.currentDuration)} / ${formatDuration(watch.totalDuration)}",
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Slider(
                  activeColor: Colors.greenAccent,
                  inactiveColor: Colors.white,
                  value: watch.currentDuration.inSeconds.toDouble(),
                  max: watch.totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    read.seekTo(Duration(seconds: value.toInt()));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.skip_previous, color: Colors.black),
                      iconSize: 40,
                      onPressed: () {
                        read.previousSong();
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        read.playOrPause();
                      },
                      icon: Icon(
                        watch.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next, color: Colors.black),
                      iconSize: 40,
                      onPressed: () {
                        read.nextSong();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, color: Colors.grey),
          // Songs List
          Expanded(
            child: ListView.builder(
              itemCount: watch.musicList.length,
              itemBuilder: (context, index) {
                final song = watch.musicList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(song.image ?? ""),
                  ),
                  title: Text(
                    song.title ?? "Unknown Title",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(song.artist ?? "Unknown Artist"),
                  // trailing: IconButton(
                  //   icon: Icon(
                  //     song.isFavorite ? Icons.favorite : Icons.favorite_border,
                  //     color: song.isFavorite ? Colors.red : Colors.grey,
                  //   ),
                  //   onPressed: () {
                  //     read.toggleFavorite(index);
                  //   },
                  // ),
                  onTap: () {
                    read.playSong(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds % 60);
    return "$minutes:$seconds";
  }
}