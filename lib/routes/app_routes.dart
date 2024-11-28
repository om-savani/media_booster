import 'package:flutter/material.dart';
import 'package:media_booster/screens/music/view/music_page.dart';

import '../screens/home/view/home_page.dart';

class AllRoutes {
  static const String home = '/';
  static const String music = 'music';

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomePage(),
    music: (context) => const MusicPage(),
  };
}
