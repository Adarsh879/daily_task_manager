import 'package:daily_task_manager/controller/task_controller.dart';
import 'package:daily_task_manager/model/tasks/task.dart';
import 'package:daily_task_manager/values/values.dart';
import 'package:daily_task_manager/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print("pressed");
          Get.dialog(Dialogs.detailsDialog(task));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: AppColors.blue,
          ),
          onPressed: () {
            Dialogs.setCompletedDialog(onAccept: () {
              if (!task.isDone) {
                Get.find<TaskController>().setCompleted(task);
              }
            });
          },
        ),
        title: Text(
          task.title,
          style: Styles.customTextStyle(
            fontSize: 16,
            color: AppColors.black,
          ),
        ),
        subtitle:
            Text("Due: " + DateFormat('dd/MM/yyyy').format(DateTime.now())),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              Dialogs.deleteDialog(
                onAccept: () => Get.find<TaskController>().deleteTask(task),
              );
            },
          ),
        ),
      ),
    );
  }
}
