import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/models/app_string.dart';
import 'package:taskati/models/task_model.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/screens/add_task.dart';
import 'package:taskati/screens/profile_screen.dart';
import 'package:taskati/taskati.dart';
import 'package:taskati/widgets/data_container.dart';
import 'package:taskati/widgets/date_addtask.dart';
import 'package:taskati/widgets/home_appBar.dart';
import 'package:taskati/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int slectedindex = 0;
  UserModel? user = Hive.box<UserModel>(AppString.userBOX).getAt(0);
  List<String> statusaList = ["All", "Complete", "TODO"];
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              themeNotifier.value == ThemeMode.light
                  ? themeNotifier.value = ThemeMode.dark
                  : themeNotifier.value = ThemeMode.light;
            },
            icon: Icon(
              (themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              HomeAppbar(user: user),
              SizedBox(height: 20),
              DateAddtask(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTask()),
                  );
                  setState(() {
                    loadTask();
                  });
                },
              ),
              SizedBox(height: 20),

              // Display status options(all, complete ,todo)
              Row(
                children: List.generate(
                  statusaList.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: DataContainer(
                        isActive: index == slectedindex,
                        statusText: statusaList[index],
                        onTap: () {
                          slectedindex = index;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Visibility(
                visible: tasks.isEmpty,
                replacement: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return TaskItem(
                      task: task,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          updateTaskStatus(task);
                        } else {
                          deleteTask(task);
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemCount: tasks.length,
                ),
                child: Lottie.asset(
                  "assets/images/emptyTasks.json",
                  repeat: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadTask() {
    if (slectedindex == 0) {
      tasks = Hive.box<TaskModel>(AppString.taskBOX).values.toList();
    } else if (slectedindex == 1) {
      tasks = Hive.box<TaskModel>(
        AppString.taskBOX,
      ).values.toList().where((e) => e.status == "Complete").toList();
    } else if (slectedindex == 2) {
      tasks = Hive.box<TaskModel>(
        AppString.taskBOX,
      ).values.toList().where((e) => e.status == "TODO").toList();
    }
  }

  var myBox = Hive.box<TaskModel>(AppString.taskBOX);
  void deleteTask(TaskModel task) {
    task.delete();
    tasks.remove(task);
    setState(() {});
  }

  void updateTaskStatus(TaskModel task) {
    task.status = "Complete";
    task.save();
    tasks.remove(task);
    setState(() {});
  }
}
