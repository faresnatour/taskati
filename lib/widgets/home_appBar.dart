import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/models/app_string.dart';
import 'package:taskati/screens/auth_screen.dart';
import 'package:taskati/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:taskati/models/user_model.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key, this.user});
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "Hello,${user?.name ?? ""}",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff4E5AE8),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Have A Nice Day",
                  style: TextStyle(fontSize: 18, color: Color(0xff121212)),
                ),
              ],
            ),
          ),
          SizedBox(width: 80,),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: CircleAvatar(
              backgroundImage: (user != null && user!.image.isNotEmpty)
                  ? FileImage(File(user!.image))
                  : null,
              radius: 30,
              backgroundColor: Color(0xff4E5AE8),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined, color: Colors.red, size: 25),
      
            onPressed: () {
              Hive.box<UserModel>(AppString.userBOX).clear();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=> AuthScreen()),(l)=>false);
            },
          ),
        ],
      ),
    );
  }
}
