import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati/models/app_string.dart';
import 'package:taskati/models/task_model.dart';
import 'package:taskati/widgets/custom_add_task_feild.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  // data Controller and use to save in hive(local storege)
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  // it to know wiht color we selected
  int indexsselected = -1;
  final List<Color> colors = [
    Color(0xff4E5AE8),
    Color(0xffFF8746),
    Color(0xffFF4667),
  ];
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xff4E5AE8),
        ),
        iconTheme: IconThemeData(color: Color(0xff4E5AE8), size: 20),
        title: Text("Add Task"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tilte",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CustomAddTaskFeild(
                  hintText: "Enter title",
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "the title is required";
                    }
                  },
                  readOnly: false,
                ),
                SizedBox(height: 10),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CustomAddTaskFeild(
                  hintText: "Enter Description",
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "the Description is required";
                    }
                  },
                  readOnly: false,
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                Text(
                  "Date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CustomAddTaskFeild(
                  hintText: "2025-05-17",
                  controller: dateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "the Date is required";
                    }
                  },
                  readOnly: true,
                  suffixIcon: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                        barrierDismissible: false,
                      ).then((value) {
                        if (value != null) {
                          dateController.text = DateFormat.yMd().format(value);
                        }
                      });
                    },

                    child: Icon(Icons.date_range),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Start Time",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomAddTaskFeild(
                            hintText: "09:30",
                            controller: startTimeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "the Start time is required";
                              }
                            },
                            readOnly: true,
                            maxLines: 1,
                            suffixIcon: InkWell(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  barrierDismissible: false,
                                ).then((value) {
                                  startTimeController.text =
                                      value?.format(context).toString() ?? " ";
                                });
                              },
                              child: Icon(Icons.alarm),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Time",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomAddTaskFeild(
                            hintText: "05:30",
                            controller: endTimeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "the End Time is required";
                              }
                            },
                            readOnly: true,
                            maxLines: 1,
                            suffixIcon: InkWell(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  barrierDismissible: false,
                                ).then((value) {
                                  endTimeController.text =
                                      value?.format(context).toString() ?? " ";
                                });
                              },
                              child: Icon(Icons.alarm),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        colors.length,
                        (index) => Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              indexsselected = index;
                              setState(() {});
                            },
                            child: CircleAvatar(
                              backgroundColor: colors[index],
                              radius: 25,
                              child: indexsselected == index
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        if (indexsselected == -1) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                "Erorr",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                "please choice the color",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                          return;
                        }
                        Hive.box<TaskModel>(AppString.taskBOX)
                            .add(
                              TaskModel(
                                taskTitle: titleController.text,
                                description: descriptionController.text,
                                startTime: startTimeController.text,
                                color: colors[indexsselected].toARGB32(),
                                date: dateController.text,
                                endTime: endTimeController.text,
                                status: "TODO",
                              ),
                            )
                            .then((value) {
                              Navigator.pop(context);
                            });
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      backgroundColor: Color(0xff4E5AE8),
                    ),

                    child: Text(
                      "Create Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
