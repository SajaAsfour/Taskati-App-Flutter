// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, camel_case_types, sort_child_properties_last
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/core/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:taskati/core/widgets/task_item.dart';
import 'package:taskati/features/add_task/add_task_screen.dart';
import 'package:taskati/features/complete_task/complete_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<DateTime> _selectedDate =
      ValueNotifier<DateTime>(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box('user');
    String name = userBox.get('name');
    String path = userBox.get('image');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              header(
                title: "Hello , ${name}",
                customWidget: CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(File(path)),
                ),
                additiondata: "",
                text: 'Have A Nice Day !',
              ),
              SizedBox(height: 5),
              
              header(
                title: DateFormat.yMMMd().format(DateTime.now()),
                customWidget: customButton(
                  text: "+ Add Task",
                  onPressed: () {
                    pushTo(context, AddTaskScreen());
                  },
                  width: 130,
                ),
                text: "Let's start!",
              ),
              SizedBox(height: 20),
              DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColor.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  _selectedDate.value = date; // Update the selected date
                },
              ),
              SizedBox(height: 15),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('task').listenable(),
                  builder: (context, Box taskBox, child) {
                    var tasks = taskBox.values.toList();
                    return ValueListenableBuilder<DateTime>(
                      valueListenable: _selectedDate,
                      builder: (context, selectedDate, child) {
                        var filteredTasks = tasks.where((task) {
                          return task.date ==
                              DateFormat('dd/MM/yyyy').format(selectedDate);
                        }).toList();

                        return ListView.builder(
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              onDismissed: (direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  var completeTaskBox =
                                      Hive.box('completeTask');
                                  completeTaskBox.put(filteredTasks[index].id,
                                      filteredTasks[index]);
                                } else {
                                  taskBox.deleteAt(index);
                                }
                              },
                              key: UniqueKey(),
                              background: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.done_all_outlined,
                                        color: AppColor.whiteColor),
                                    SizedBox(width: 5),
                                    Text(
                                      "Complete",
                                      style: getSmallTextStyle(
                                          color: AppColor.whiteColor),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.greenColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.shade200,
                                      blurRadius: 0,
                                      offset: Offset(2, 4),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.only(bottom: 10),
                              ),
                              secondaryBackground: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.delete,
                                        color: AppColor.whiteColor),
                                    SizedBox(width: 5),
                                    Text(
                                      "Delete",
                                      style: getSmallTextStyle(
                                          color: AppColor.whiteColor),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.redColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0,
                                      offset: Offset(2, 4),
                                      color: Colors.red.shade200,
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.only(bottom: 10),
                              ),
                              child: task_item(
                                  task: filteredTasks[index], text: 'TODO'),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              customButton(
                text: "Show completed Task",
                onPressed: () {
                  pushTo(context, CompleteTask());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
