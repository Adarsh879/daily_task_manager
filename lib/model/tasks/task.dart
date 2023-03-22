import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

enum Priority { low, medium, high }

class Task {
  String? id;
  String title;
  String description;
  Priority priority;
  DateTime dueDate;
  bool isDone;

  Task({
    this.id,
    required this.title,
    this.isDone = false,
    this.priority = Priority.low,
    required this.dueDate,
    required this.description,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        priority: Priority.values[json['priority'] as int],
        dueDate: DateTime.parse(json['dueDate'] as String),
        isDone: json['isDone'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority.index,
        'dueDate': dueDate.toIso8601String(),
        'isDone': isDone,
      };

  String toJsonString() => jsonEncode(toJson());

  static Task? fromJsonString(String jsonString) =>
      Task.fromJson(jsonDecode(jsonString));
}
