import 'package:flutter/material.dart';
import 'package:netflix/screens/splash.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // color: Colors.black,
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      home: const Splash(),);
  }
}
