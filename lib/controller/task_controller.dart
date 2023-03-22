import 'dart:math';

import 'package:daily_task_manager/model/tasks/task.dart';
import 'package:daily_task_manager/model/tasks/task_respository.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  TaskController(TaskRepository taskRepo) : this._taskRepo = taskRepo;

  var tasks = <Task>[].obs;
  var isLoading = false.obs;
  var showCompletedTasks = false.obs;
  var initLoading = false.obs;
  var reachedFinal = false;
  var fetching = false.obs;
  String? searchText;
  TaskRepository _taskRepo;

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> addTask(String title, String discription, DateTime dueDate,
      Priority priority) async {
    isLoading.value = true;
    final task = Task(
      title: title,
      description: discription,
      priority: priority,
      dueDate: dueDate,
    );
    try {
      await _taskRepo.addTask(task);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }

  Future<void> deleteTask(Task task) async {
    isLoading.value = true;
    try {
      await _taskRepo.deleteTask(task);
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
    reload();
  }

  Future<void> setCompleted(Task task) async {
    isLoading.value = true;
    try {
      await _taskRepo.setCompleted(task);
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
    reload();
  }

  Future<void> fetch({String? searchText}) async {
    List<Task>? fetchedTasks;
    print("fetch called");
    if (tasks.value.isEmpty) {
      initLoading.value = true;
    }
    fetching.value = true;
    try {
      fetchedTasks = await _taskRepo.getTasks(
          showCompleted: showCompletedTasks.value,
          limit: 10,
          searchText: searchText);
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString());
    }
    if (fetchedTasks == null) {
      reachedFinal = true;
    } else {
      tasks.value = [...tasks.value, ...fetchedTasks];
    }
    fetching.value = false;
    if (initLoading.value) {
      initLoading.value = false;
    }
  }

  void reload() {
    reset();
    _taskRepo.reset();
    fetch();
  }

  void reset() {
    tasks.value.clear();
    reachedFinal = false;
  }

  void toggleShowCompletedTasks() {
    showCompletedTasks.value = !showCompletedTasks.value;
    reset();
    fetch();
  }
}
