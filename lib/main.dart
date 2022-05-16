import 'package:flutter/material.dart';
import 'package:holland/screen/loginPage.dart';
import 'package:flutter/services.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// var box;
void main() {
  // await Hive.initFlutter();
  // box = await Hive.openBox('hobox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Holland App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
