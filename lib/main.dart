import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:media_booster/provider/main_provider.dart';
import 'package:media_booster/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
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
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
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
          ;
        },
      ),
    );
  }
}
