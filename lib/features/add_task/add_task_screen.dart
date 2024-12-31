// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var titleContrller = TextEditingController();
    var noteContrller = TextEditingController();
    var dateContrller = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Task"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: getTitleTextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: titleContrller,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Note",
                style: getTitleTextStyle(
                    color: AppColor.primaryColor, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                maxLines: 4,
                controller: noteContrller,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Date",
                style: getTitleTextStyle(
                    color: AppColor.primaryColor, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2026),
                    initialDate: DateTime.now(),
                  ).then((value) {
                    if (value != null) {
                      dateContrller.text =
                          DateFormat("dd/MM/yyyy").format(value);
                    }
                  });
                },
                readOnly: true,
                controller: dateContrller,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                  Icons.calendar_month,
                  color: AppColor.primaryColor,
                )),
              ),
            ],
          ),
        ));
  }
}
