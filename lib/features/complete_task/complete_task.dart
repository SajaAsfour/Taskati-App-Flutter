import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/widgets/task_item.dart';

class CompleteTask extends StatelessWidget {
  const CompleteTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Completed Task",
          style: TextStyle(
              fontFamily: "Times New Roman", color: AppColor.whiteColor),
        ),
        iconTheme: IconThemeData(
          color: AppColor.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('completeTask').listenable(),
                builder: (context, Box completeTask, child) {
                  var tasksCompleted = completeTask.values.toList();
                  return ListView.builder(
                    itemCount: completeTask.length,
                    itemBuilder: (context, index) {
                      return task_item(
                        task: tasksCompleted[index],
                        text: 'DONE',
                        additiondata: tasksCompleted[index].note +
                            "\n" +
                            "Task Date: " +
                            tasksCompleted[index].date,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
