// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/features/intro/splash_screen.dart';

void main() async{
  // use it with async to ensure initialize data
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
}
}
