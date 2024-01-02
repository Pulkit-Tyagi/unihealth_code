import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/views/splash_screen_view.dart';

void main() {
  runApp(ProviderScope(child: MyApp(),));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var clr = AppConstColor().appThemeColor;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: clr),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
