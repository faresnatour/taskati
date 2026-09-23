import 'package:flutter/material.dart';
import 'package:taskati/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task, this.onDismissed});
  final TaskModel task;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible( 
      onDismissed: onDismissed,
      key: ValueKey(task.key),
      background: Container(
        height: 100,
        color: Colors.green,
        child: Row(
          children: [
            Icon(Icons.done),
            Text(
              "Complete",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        height: 100,
        color: Colors.red,
        child: Row(
          children: [
            Icon(Icons.delete),
            Text("Delete", style: TextStyle(color: Colors.white, fontSize: 15)),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(task.color),
        ),

        child: Row(
          children: [
            Expanded(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.taskTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.alarm, color: Colors.white, size: 15),
                      Text(
                        "${task.startTime}-${task.endTime}",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),

                  Text(
                    task.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(width: 30),
            Container(height: 85, width: 1, color: Colors.white),
            RotatedBox(
              quarterTurns: 15,
              child: Text(
                task.status,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
