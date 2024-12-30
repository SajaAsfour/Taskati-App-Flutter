// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/core/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box('user');
    String name = userBox.get('name');
    String path = userBox.get('image');
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            header(
              title: "Hello , ${name}",
              customWidget: CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(path)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            header(
                title: DateFormat.yMMMd().format(DateTime.now()),
                customWidget: customButton(
                  text: "+ Add Task",
                  onPressed: () {},
                  width: 130,
                )),
            SizedBox(
              height: 20,
            ),
            DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: AppColor.primaryColor,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
              },
            ),
          ],
        ),
      ),
    ));
  }
}
