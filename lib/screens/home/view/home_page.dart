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
              icon: Icon(Icons.music_note),
              text: 'Audio',
            ),
            Tab(
              icon: Icon(Icons.video_collection),
              text: 'Video',
            ),
          ],
        ),
      ),
      body: TabBarView(
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
                  minLeadingWidth: 60,
                  onTap: () {
                    read.playSong(index);
                    Navigator.pushNamed(context, AllRoutes.music,
                        arguments: watch.musicList[index]);
                  },
                  contentPadding: const EdgeInsets.all(10),
                  leading: CachedNetworkImage(
                    imageUrl: watch.musicList[index].image ?? "",
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: 60,
                    height: 60,
                  ),
                  title: Text(watch.musicList[index].title ?? "Unknown Title"),
                  // trailing: IconButton(
                  //   icon: const Icon(Icons.play_arrow, color: Colors.black),
                  //   onPressed: () {
                  //
                  //   },
                  // ),
                ),
              );
            },
          ),
          Column(
            children: [
              Center(
                child: Container(
                  height: 300,
                  width: 400,
                  child: Chewie(
                    controller: watch.chewieController!,
                  ),
                ),
                // : const CircularProgressIndicator(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
