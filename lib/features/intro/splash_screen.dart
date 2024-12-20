// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/upload/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      pushWithReplacement(context, UploadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("./assets/images/logo.json"),
            Text("Taskati", style: getTitleTextStyle()),
            Text(
              "it's time to get organized",
              style: getBodyTextStyle(color: AppColor.greyColor),
            ),
          ],
        ),
      ),
    );
  }
}
