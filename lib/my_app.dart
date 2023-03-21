import 'package:flutter/material.dart';
import 'package:josequal/components/themes/app_theme.dart';
import 'package:josequal/pages/landing_page/landing_page.dart';
import 'package:josequal/services/favorite_servise.dart';
import 'package:josequal/services/wallpapers_servise.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WallpapersServices>(
            create: (context) => WallpapersServices()),
        ChangeNotifierProvider<FavoriteServices>(
            create: (context) => FavoriteServices()),
      ],
      child: MaterialApp(
        title: 'JoSequal Task',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const LandingPage()
        },
      ),
    );
  }
}
