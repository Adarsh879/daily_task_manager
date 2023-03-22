import 'package:daily_task_manager/controller/form_controllers/add_task_controller.dart';
import 'package:daily_task_manager/controller/task_controller.dart';
import 'package:daily_task_manager/model/tasks/task.dart';
import 'package:daily_task_manager/values/values.dart';
import 'package:daily_task_manager/widgets/custom_text_form_field.dart';
import 'package:daily_task_manager/widgets/cutomButton.dart';
import 'package:daily_task_manager/widgets/drop_down_options.dart';
import 'package:daily_task_manager/widgets/loader.dart';
import 'package:daily_task_manager/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late DateTime currentdate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  int? _selectedPriority;
  AddTaskFormController _addTaskFormController =
      Get.put(AddTaskFormController());
  TaskController _taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _buildform(context),
              ),
            ),
            Obx(() => _taskController.isLoading.value ? Loader() : SizedBox()),
          ],
        ),
      ),
    );
  }

  Form _buildform(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SpaceH16(),
          CustomTextFormField(
            hasTitle: true,
            title: StringConst.TITLE,
            titleStyle: Styles.customTextStyle(
              color: AppColors.deepDarkGreen,
              fontSize: Sizes.TEXT_SIZE_14,
            ),
            textInputType: TextInputType.text,
            hintTextStyle: Styles.customTextStyle(
              color: AppColors.greyShade7,
            ),
            enabledBorder: Borders.outlineEnabledBorder,
            focusedBorder: Borders.outlineFocusedBorder,
            textStyle: Styles.customTextStyle(
              color: AppColors.blackShade10,
            ),
            border: Borders.enabledBorder,
            isCircular: true,
            borderRadius: BorderRadius.circular(50),
            hintText: StringConst.TITLE_HINT_TEXT,
            onChanged: (value) => _addTaskFormController.setTitle(value),
            validator: (value) => _addTaskFormController.validateTitle(value),
          ),
          const SpaceH16(),
          CustomTextFormField(
            title: StringConst.DESCRIPTION,
            hasTitle: true,
            hintText: StringConst.ENTER_DESCRIPTION,
            enabledBorder: Borders.outlineEnabledBorder,
            focusedBorder: Borders.outlineFocusedBorder,
            hintTextStyle: Styles.customTextStyle(
              color: AppColors.greyShade7,
            ),
            textStyle: Styles.customTextStyle(
              color: AppColors.blackShade10,
            ),
            titleStyle: Styles.customTextStyle(
              color: AppColors.deepDarkGreen,
              fontSize: Sizes.TEXT_SIZE_14,
            ),
            isCircular: true,
            maxLines: 5,
            prefixIcon: Icon(Icons.ac_unit),
            hasPrefixIcon: false,
            onChanged: (value) => _addTaskFormController.setDescription(value),
            validator: (value) =>
                _addTaskFormController.validateDescription(value),
          ),
          const SpaceH16(),
          Obx(
            () => CustomTextFormField(
              title: StringConst.DATE,
              hasTitle: true,
              hintText: DateFormat('dd/MM/yyyy')
                  .format(_addTaskFormController.dueDate.value),
              enabledBorder: Borders.outlineEnabledBorder,
              focusedBorder: Borders.outlineFocusedBorder,
              hintTextStyle: Styles.customTextStyle(
                color: AppColors.greyShade7,
              ),
              textStyle: Styles.customTextStyle(
                color: AppColors.blackShade10,
              ),
              titleStyle: Styles.customTextStyle(
                color: AppColors.deepDarkGreen,
                fontSize: Sizes.TEXT_SIZE_14,
              ),
              suffixIcon: Icon(Icons.calendar_today),
              isCircular: true,
              readonly: true,
              hasSuffixIcon: true,
              validator: (_) => _addTaskFormController.validateDueDate(),
              onTap: () async {
                DateTime? dueDate = await _showdatepicker();
                if (dueDate != null) {
                  _addTaskFormController.setDueDate(dueDate);
                }
              },
            ),
          ),
          const SpaceH16(),
          Text(
            StringConst.PRIORITY,
            style: Styles.customTextStyle(),
          ),
          const SpaceH12(),
          _buildDropdownButton(context),
          const SpaceH16(),
          CustomButton(
            color: AppColors.purple,
            title: 'Create Task',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _taskController
                    .addTask(
                  _addTaskFormController.title,
                  _addTaskFormController.description,
                  _addTaskFormController.dueDate.value,
                  _addTaskFormController.priority.value,
                )
                    .then((value) {
                  _taskController.reload();
                  Get.back();
                });
              }
            },
          )
        ],
      ),
    );
  }

  _buildDropdownButton(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField<Priority>(
        value: _addTaskFormController.priority.value,
        items: menuItems,
        style: Styles.customTextStyle(color: AppColors.purple),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.purple,
          size: Sizes.ELEVATION_14,
        ),
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 0,
              )),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: Sizes.SIZE_12, vertical: Sizes.SIZE_12),
        ),
        onChanged: (Priority? val) {
          if (val != null) {
            _addTaskFormController.setPriority(val);
          }
        },
      ),
    );
  }

  Future<DateTime?> _showdatepicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
      currentDate: _addTaskFormController.dueDate.value,
    );
    return selectedDate;
  }

  Row _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.chevron_left,
            size: Sizes.ICON_SIZE_32,
          ),
        ),
        Text(
          'Add Task',
          style: Styles.customTextStyle(
            fontSize: Sizes.TEXT_SIZE_28,
            color: AppColors.black,
          ),
        ),
        const SizedBox()
      ],
    );
  }
}
