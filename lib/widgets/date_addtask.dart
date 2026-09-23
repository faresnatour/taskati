import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:taskati/screens/add_task.dart';

class DateAddtask extends StatelessWidget {
  const DateAddtask({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              // example : "October 30, 2023"
               DateFormat.yMEd().format(DateTime.now()),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Today",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff4E5AE8),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.add, size: 18,fontWeight: FontWeight.bold ,),
                SizedBox(width: 10),
                Text("Add Task", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
