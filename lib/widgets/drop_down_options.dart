import 'package:daily_task_manager/model/tasks/task.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem<Priority>> menuItems = const [
  DropdownMenuItem(
      child: Text(
        "High",
      ),
      value: Priority.high),
  DropdownMenuItem(
      child: Text(
        "Medium",
      ),
      value: Priority.medium),
  DropdownMenuItem(
      child: Text(
        "Low",
      ),
      value: Priority.low),
];
