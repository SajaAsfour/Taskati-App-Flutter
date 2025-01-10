// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/home/home_screen.dart';
import 'package:taskati/model/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  int selectedColor = 0;
  var titleContrller = TextEditingController();
  var noteContrller = TextEditingController();
  var dateContrller = TextEditingController(
    text: DateFormat("dd/MM/yyyy").format(DateTime.now()),
  );
  var startTimeController = TextEditingController(
    text: DateFormat("hh:mm a").format(DateTime.now()),
  );
  var endTimeController = TextEditingController(
    text: DateFormat("hh:mm a").format(DateTime.now()),
  );
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Task",
            style: TextStyle(
                fontFamily: "Times New Roman", color: AppColor.whiteColor),
          ),
          iconTheme: IconThemeData(
            color: AppColor.whiteColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
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
                    validator: (value) {
                      if (value != null) {
                        if (value.length < 5) {
                          return "Invalid Title , Minimum length is 5";
                        }
                        return null;
                      }
                    },
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
                    maxLines: 3,
                    controller: noteContrller,
                    validator: (value) {
                      if (value != null) {
                        if (value.length < 10) {
                          return "Invalid Note , Minimum lenght is 10";
                        }
                      }
                    },
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Time",
                              style: getTitleTextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              controller: startTimeController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(
                                Icons.access_time,
                                color: AppColor.primaryColor,
                              )),
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  if (value != null) {
                                    startTimeController.text =
                                        value.format(context);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End Time",
                              style: getTitleTextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.access_time,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              readOnly: true,
                              controller: endTimeController,
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  if (value != null) {
                                    endTimeController.text =
                                        value.format(context);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          3,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(1),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = index;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  child: selectedColor == index
                                      ? Icon(
                                          Icons.check,
                                          color: AppColor.whiteColor,
                                          size: 17,
                                        )
                                      : null,
                                  backgroundColor: index == 0
                                      ? AppColor.primaryColor
                                      : index == 1
                                          ? AppColor.orangeColor
                                          : AppColor.redColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Spacer(),
                      customButton(
                        text: "Create Task",
                        width: 150,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (!((DateFormat("hh:mm a").parse(endTimeController.text).isAfter(DateFormat("hh:mm a").parse(startTimeController.text))))){
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Error: End time must be after start time.'),
                                  backgroundColor: AppColor.redColor,
                                ),
                              );
                              return;
                            }
                            TaskModel newTask = TaskModel(
                              id: UniqueKey().toString(),
                              title: titleContrller.text,
                              note: noteContrller.text,
                              date: dateContrller.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              Color: selectedColor,
                              isCompleted: false,
                            );
                            var taskBox = Hive.box('task');
                            taskBox.put(newTask.id, newTask);
                            pushWithReplacement(context, HomeScreen());
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
