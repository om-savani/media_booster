import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/main_provider.dart';
import '../../../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  MainProvider read = MainProvider();
  MainProvider watch = MainProvider();
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    // context.read<MainProvider>().init().then((_) {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<MainProvider>();
    watch = context.watch<MainProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Booster'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.music_note,
                color: Colors.greenAccent,
              ),
              text: 'Audio',
            ),
            Tab(
              icon: Icon(
                Icons.video_collection,
                color: Colors.greenAccent,
              ),
              text: 'Video',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TabBarView(
          controller: tabController,
          children: [
            ListView.builder(
              itemCount: watch.musicList.length,
              itemBuilder: (context, index) {
                final song = watch.musicList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    minTileHeight: 45,
                    onTap: () {
                      read.playSong(index);
                      Navigator.pushNamed(context, AllRoutes.music,
                          arguments: watch.musicList[index]);
                    },
                    contentPadding: const EdgeInsets.all(10),
                    leading: Container(
                      height: 80,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(song.image ?? ""),
                          )),
                    ),
                    title: Text(
                      watch.musicList[index].title ?? "Unknown Title",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      song.artist ?? "Unknown Artist",
                      style:
                          TextStyle(color: Colors.grey.shade100, fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        watch.isPlaying && watch.currentIndex == index
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.greenAccent,
                      ),
                      onPressed: () {
                        if (watch.isPlaying && watch.currentIndex == index) {
                          read.pauseSong();
                        } else {
                          read.playSong(index);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            Column(
              children: [
                if (watch.isVideoInitialized)
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Chewie(
                      controller: watch.chewieController!,
                    ),
                  )
                else
                  const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
