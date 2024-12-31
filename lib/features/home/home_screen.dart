// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/core/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:taskati/features/add_task/add_task_screen.dart';

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
                  onPressed: () {
                    pushTo(context, AddTaskScreen());
                  },
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Flutter Task 1",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: getTitleTextStyle(
                                    fontSize: 16,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      color: AppColor.whiteColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "10:00 AM : 11:00 AM",
                                      style: getBodyTextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: 15),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 50,
                            color: AppColor.whiteColor,
                          ),
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "TODO",
                              style: getSmallTextStyle(
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
