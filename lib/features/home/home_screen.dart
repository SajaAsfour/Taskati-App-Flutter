// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          var userBox = Hive.box('user');
          print("user name is :" + userBox.get('name'));
          print("user image is :" + userBox.get('image')) ;
        }, child: Text("Show Data"))
      ),
    );
  }
}
