import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_task_manager/firebase_options.dart';
import 'package:daily_task_manager/model/tasks/task.dart';
import 'package:firebase_core/firebase_core.dart';

class TaskRepository {
  final String userId;
  late final CollectionReference _tasksCollection;
  DocumentSnapshot? _lastDocumentSnapshot;
  bool? _lastShowCompleted;
  String? _lastText;

  TaskRepository({required this.userId})
      : _tasksCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('tasks');
  Future<void> addTask(Task task) async {
    await _tasksCollection.add(task.toJson());
  }

  Future<List<Task>?> getTasks({
    required bool showCompleted,
    required int limit,
    //used to search based query
    String? searchText,
  }) async {
    print("get task called");
    //making _lastDocumentSnapshot to point to new query
    if ((_lastShowCompleted != null && _lastShowCompleted != showCompleted) ||
        (_lastText != null && _lastText != searchText)) {
      _lastDocumentSnapshot = null;
    }
    Query query = showCompleted
        ? _tasksCollection.where('isDone', isEqualTo: true)
        : _tasksCollection.where('isDone', isEqualTo: false);
    //searching operation
    if (searchText != null) {
      query = query
          .where('title', isGreaterThanOrEqualTo: searchText)
          .where('title', isLessThanOrEqualTo: searchText + '\uf8ff')
          .orderBy('title');
    }

    query = query.orderBy('priority', descending: true);
    query = query.limit(limit);
    // If we have a last document snapshot, use it to get the next page of results
    if (_lastDocumentSnapshot != null) {
      query = query.startAfterDocument(_lastDocumentSnapshot!);
    }
    // Retrieve the tasks from Firestore and convert them to a List<Task>
    QuerySnapshot snapshot = await query.get();
    List<Task>? tasks = snapshot.docs.map((doc) {
      return Task.fromJson({
        'id': doc.id,
        ...(doc.data() as Map<String, dynamic>)..remove('id')
      });
    }).toList();
    tasks.forEach((element) {
      print(element.toJsonString());
    });
    // Update the last document snapshot
    _lastDocumentSnapshot =
        snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    _lastShowCompleted = showCompleted;
    _lastText = searchText;

    if (snapshot.docs.isNotEmpty) {
      return tasks;
    } else {
      return null;
    }
  }

  Future<void> deleteTask(Task task) async {
    await _tasksCollection.doc(task.id).delete();
  }

  Future<void> setCompleted(Task task) async {
    await _tasksCollection.doc(task.id).update({'isDone': true});
  }

  Future<List<Task>?> reset() async {
    _lastDocumentSnapshot = null;
  }
}

// Future<void> main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   TaskRepository taskRepo =
//       TaskRepository(userId: 't51RSvjkYddLU4lRXjTMNcnVVMU2');
//   List<Task>? tasks = await taskRepo.getTasks(
//       showCompleted: false, limit: 10, searchText: "Task 1");
//   print(tasks);
//   while (tasks != null) {
//     for (Task task in tasks) {
//       print(task.toJsonString());
//     }
//     tasks = await taskRepo.getTasks(
//         showCompleted: false, limit: 10, searchText: "Task 1");
//   }
// }
