import 'package:daily_task_manager/model/tasks/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Dialogs {
  static detailsDialog(Task task) {
    return AlertDialog(
      title: Text(task.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description: ${task.description}'),
          SizedBox(height: 10),
          Text('Due Date: ${DateFormat('dd/MM/yyyy').format(task.dueDate)}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  static deleteDialog({required void Function() onAccept}) {
    Get.defaultDialog(
      title: 'Delete Task',
      middleText: 'Would you like to delete the Task?',
      textConfirm: 'OK',
      textCancel: 'Cancel',
      onConfirm: () {
        onAccept();
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  static setCompletedDialog({required void Function() onAccept}) {
    Get.defaultDialog(
      title: 'Mark completed',
      middleText: 'Would you like to set this task as completed?',
      textConfirm: 'OK',
      textCancel: 'Cancel',
      onConfirm: () {
        onAccept();
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
