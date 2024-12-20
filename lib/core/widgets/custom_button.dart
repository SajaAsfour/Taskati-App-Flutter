// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class customButton extends StatelessWidget {
  final String text ;

  const customButton({
    super.key,
    required this.text ,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: ElevatedButton(
          onPressed: () {},
          child: Text(
            text,
            style: getBodyTextStyle(color: AppColor.whiteColor),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          )),
    );
  }
}
