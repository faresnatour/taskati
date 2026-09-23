import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/models/app_string.dart';
import 'package:taskati/models/task_model.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/taskati.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(AppString.userBOX);
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>(AppString.taskBOX);
  runApp(Taskati());
}
