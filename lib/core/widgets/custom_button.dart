// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class customButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? txtColor;
  final Function () onPressed;
  const customButton({
    super.key,
    required this.text,
    this.width = 250,
    this.height = 45,
    this.backgroundColor,
    this.txtColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: getSmallTextStyle(
              color: txtColor?? AppColor.whiteColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor?? AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
    );
  }
}
