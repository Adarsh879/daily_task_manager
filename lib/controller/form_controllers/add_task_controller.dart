import 'package:daily_task_manager/model/tasks/task.dart';
import 'package:get/get.dart';

class AddTaskFormController extends GetxController {
  final RxString _title = ''.obs;
  final RxString _description = ''.obs;
  final Rx<DateTime> _dueDate = DateTime.now().obs;
  final Rx<Priority> _priority = Priority.low.obs;

  String get title => _title.value;
  String get description => _description.value;
  Rx<DateTime> get dueDate => _dueDate;
  Rx<Priority> get priority => _priority;

  final _titleError = Rx<String?>(null);
  final _descriptionError = Rx<String?>(null);
  final _dueDateError = Rx<String?>(null);

  String? get titleError => _titleError.value;
  String? get descriptionError => _descriptionError.value;
  String? get dueDateError => _dueDateError.value;

  void setTitle(String title) => _title.value = title;
  void setDescription(String description) => _description.value = description;
  void setDueDate(DateTime dueDate) => _dueDate.value = dueDate;
  void setPriority(Priority priority) => _priority.value = priority;

  String? validateTitle(String? title) {
    if (title != null && title.isEmpty) {
      return 'Title is required';
    } else if (title!.length > 50) {
      return 'The Title must not be longer than 45 characters';
    } else {
      return null;
    }
  }

  String? validateDescription(String? description) {
    if (description != null && description.isEmpty) {
      return 'Description is required';
    } else if (description!.length > 100) {
      return 'The description must not be longer than 100 characters';
    } else {
      return null;
    }
  }

  String? validateDueDate() {
    if (_dueDate.value.isBefore(DateTime.now())) {
      return 'Due date is required and must be in the future';
    } else {
      return null;
    }
  }

  // String formatDate(DateTime date) {
  //   return DateFormat('MMM dd, yyyy').format(date);
  // }
}
