// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/upload/upload_screen.dart';

class header extends StatelessWidget {
  const header({
    super.key,
    required this.title,
    required this.customWidget,
    required this.text,
    this.additiondata,
  });

  final String title;
  final Widget customWidget;
  final String text;
  final String? additiondata;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getTitleTextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              text,
              style: getBodyTextStyle(),
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            customWidget,
            if (additiondata != null)
              GestureDetector(
                onTap: () {
                  pushTo(context, UploadScreen());
                },
                child: Text(
                  'Update Your Profile',
                  style: getSmallTextStyle(),
                ),
              )
          ],
        ),
      ],
    );
  }
}
