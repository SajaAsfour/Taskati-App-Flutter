// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/features/home/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  final ImagePicker picker = ImagePicker();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async{
                if (formKey.currentState!.validate() && path != null) {
                  var userBox = Hive.box('user');
                  userBox.put('name', nameController.text);
                  userBox.put('image',path);
                  userBox.put('isUploaded', true);
                  pushWithReplacement(context, HomeScreen());
                } else if (path == null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              "Error",
                              style: getSmallTextStyle(),
                            ),
                          ),
                          content: Text(
                            "Please Load Your Image",
                            style: getBodyTextStyle(
                                fontSize: 16,
                                color: AppColor.dartColor,
                                fontWeight: FontWeight.w400),
                          ),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Ok"))
                          ],
                        );
                      });
                }
              },
              child: Text(
                "Done",
                style: getSmallTextStyle(),
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: path != null
                    ? FileImage(File(path!))
                    : NetworkImage("https://picsum.photos/200"),
              ),
              SizedBox(
                height: 30,
              ),
              customButton(
                text: "Upload From Camera",
                onPressed: () async {
                  await ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then(
                    (value) {
                      if (value != null) {
                        setState(() {
                          path = value.path;
                        });
                        path = value.path;
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              customButton(
                text: "Upload From Gallery",
                onPressed: () async {
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      path = image.path;
                    });
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: AppColor.primaryColor,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name Is Required";
                    } else if (!RegExp('^[A-Z][a-z]{2,8}').hasMatch(value)) {
                      return "Name must be a capital charcter then small chracter\nAnd its length from 2 to 8";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name Here ...",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColor.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColor.primaryColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
