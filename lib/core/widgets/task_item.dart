// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, camel_case_types

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/model/task_model.dart';

class task_item extends StatelessWidget {
  const task_item({
    super.key,
    required this.task,
    required this.text,
    this.additiondata,
  });

  final TaskModel task;
  final String text;
  final String? additiondata;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: task.Color == 0
              ? AppColor.primaryColor
              : task.Color == 1
                  ? AppColor.orangeColor
                  : AppColor.redColor,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
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
                      "${task.startTime} : ${task.endTime}",
                      style: getBodyTextStyle(
                          color: AppColor.whiteColor, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                if (additiondata != null)
                  Text(
                    "Task Note: " + additiondata!,
                    style: getBodyTextStyle(
                        color: AppColor.whiteColor, fontSize: 15),
                  ),
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
              text,
              style: getSmallTextStyle(
                color: AppColor.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
