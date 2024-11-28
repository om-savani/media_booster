import 'package:flutter/material.dart';
import 'package:media_booster/provider/main_provider.dart';
import 'package:media_booster/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MainProvider()),
      ],
      child: Consumer<MainProvider>(
        builder: (BuildContext context, value, Widget? child) {
          // value.init();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: AllRoutes.routes,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                    foregroundColor: Colors.greenAccent,
                    backgroundColor: Colors.transparent),
              ),
            ),
            themeMode: ThemeMode.dark,
            theme: ThemeData(
              colorSchemeSeed: Colors.greenAccent,
            ),
          );
        },
      ),
    );
  }
}
