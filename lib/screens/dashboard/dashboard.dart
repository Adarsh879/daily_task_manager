import 'package:daily_task_manager/controller/auth_controller.dart';
import 'package:daily_task_manager/controller/task_controller.dart';
import 'package:daily_task_manager/model/tasks/task.dart';
import 'package:daily_task_manager/model/tasks/task_respository.dart';
import 'package:daily_task_manager/screens/dashboard/widgets/todo_item.dart';
import 'package:daily_task_manager/values/values.dart';
import 'package:daily_task_manager/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  // final tasksList = Task.taskList();
  final _taskController = Get.put(TaskController(
      TaskRepository(userId: Get.find<AuthController>().user.value!.uid)));
  final _scrollController = ScrollController();
  String? searchText;

  @override
  void initState() {
    bool lock = false;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !lock &&
          !_taskController.reachedFinal) {
        lock = true;
        _taskController
            .fetch(searchText: searchText)
            .then((value) => lock = false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Obx(
                          () => DropdownButton<String>(
                            value: _taskController.showCompletedTasks.value
                                ? 'Completed'
                                : 'Todo',
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                              color: AppColors.blackShade3,
                              fontSize: Sizes.TEXT_SIZE_30,
                              fontWeight: FontWeight.w500,
                            ),
                            underline: Container(),
                            onChanged: (String? newValue) =>
                                _taskController.toggleShowCompletedTasks(),
                            items: <String>['Todo', 'Completed']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Obx(
                        () => _taskController.initLoading.value
                            ? ListViewLoader()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount:
                                    _taskController.tasks.value.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (_taskController.tasks.value.length == 0) {
                                    return Center(
                                      child: Text(
                                        "No tasks present",
                                        style: Styles.customTextStyle(
                                            color: AppColors.black,
                                            fontSize: Sizes.TEXT_SIZE_16),
                                      ),
                                    );
                                  }
                                  if (index == _taskController.tasks.length) {
                                    return Obx(
                                      () => Visibility(
                                        visible: _taskController.fetching.value,
                                        child: const Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                    );
                                  }
                                  final task = _taskController.tasks[index];
                                  return TaskItem(
                                    task: task,
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/addTask");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Obx(() => _taskController.isLoading.value ? Loader() : SizedBox()),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) {
          if (_taskController.fetching.value == true) {
            _taskController.reset();
          }
          if (value != null || value.isNotEmpty) {
            searchText = value;
            _taskController.reset();
            _taskController.fetch(searchText: value);
          } else {
            searchText = null;
            _taskController.reload();
          }
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColors.grey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.grey,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
          onTap: () => Get.find<AuthController>().logOut(),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Logout",
                  style: Styles.customTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.logout_sharp,
                  color: Colors.deepOrange,
                )
              ]),
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
          ),
        ),
      ]),
    );
  }
}
