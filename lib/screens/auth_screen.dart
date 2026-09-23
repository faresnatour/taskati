import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/models/app_string.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/screens/home_screen.dart';
import 'package:taskati/widgets/custom_auth_elevated_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  TextEditingController nameController = TextEditingController();

  void openCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void openGallery() async {
    photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void addUser() async {
    try {
      final box = Hive.box<UserModel>(AppString.userBOX);
      await box.clear();
       await box.add(UserModel(image: photo?.path ?? "", name: nameController.text));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("error"),
          content: Text("error data try again"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: photo == null,
                  replacement: CircleAvatar(
                    backgroundColor: Color(0xff121212),
                    radius: 90,
                    backgroundImage: Image.file(File(photo?.path ?? " ")).image,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Color(0xff121212),
                    radius: 90,
                    child: Icon(
                      Icons.person,
                      color: Color(0XFF4E5AE8),
                      size: 150,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CustomAuthElevatedButton(
                  text: "Upload From Camera",
                  onPressed: openCamera,
                ),
                SizedBox(height: 15),
                CustomAuthElevatedButton(
                  text: "Upload From Gallery",
                  onPressed: openGallery,
                ),
                SizedBox(height: 10),
                Divider(thickness: 3),
                SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xff4E5AE8)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomAuthElevatedButton(text: "Done", onPressed: addUser),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
