import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/models/app_string.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/widgets/custom_auth_elevated_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();
  UserModel? user = Hive.box<UserModel>(AppString.userBOX).get(0);
  XFile? photo;
  TextEditingController nameController = TextEditingController();
  void openCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      user!.image = photo!.path;
      await user!.save();
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  void openGallery() async {
    photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      user!.image = photo!.path;
      await user!.save();
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Color(0xff4E5AE8)),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffB4AAAA),
                    radius: 50,
                    backgroundImage: (user != null && user!.image.isNotEmpty)
                        ? FileImage(File(user!.image))
                        : null,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => openCamera(),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xff4E5AE8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Upload from Camera",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),

                              InkWell(
                                onTap: () => openGallery(),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xff4E5AE8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Upload from Gallery",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.camera_alt_sharp,
                      color: Color(0xff4E5AE8),
                      size: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user?.name ?? "",
                      style: TextStyle(
                        color: Color(0xff4E5AE8),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    label: Text(user!.name),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xff4E5AE8),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                CustomAuthElevatedButton(
                                  text: "Update your name ",

                                  onPressed: () async {
                                    if (nameController.text.isEmpty) {
                                      return;
                                    }
                                    user!.name = nameController.text;
                                    await user!.save();
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.edit_note,
                        color: Color(0xff4E5AE8),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
