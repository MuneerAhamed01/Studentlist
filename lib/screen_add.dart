import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentlist/adapters/studentlist.dart';
import 'package:studentlist/screen_show.dart';
import 'package:studentlist/screenone.dart';

class screenAdd extends StatefulWidget {
  const screenAdd({Key? key}) : super(key: key);

  @override
  State<screenAdd> createState() => _screenAddState();
}

class _screenAddState extends State<screenAdd> {
  final _formkey = GlobalKey<FormState>();
  String? image;
  String? name;
  String? phone;
  String? adress;
  String? subject;
  XFile? imageOn;
  // String? file = File(imageOn!.path);
  final ImagePicker ImageOf = ImagePicker();

  // String pattern = ;
  RegExp regExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("Add Students"),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageOn?.path != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(File(imageOn!.path)),
                        )
                      : CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.red,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          labelText: "Name"),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "This Field is required";
                        } else {
                          // name = value;
                          name = value;
                          return null;
                        }
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          labelText: "Phone Number"),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "This Field is required";
                        } else if (!regExp.hasMatch(value)) {
                          return "Enter a valid number";
                        } else {
                          phone = value;
                          return null;
                        }
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          labelText: "Subject"),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "This Field is required";
                        } else {
                          subject = value;
                          return null;
                        }
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          hintText: "Address"),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "This Field is required";
                        } else {
                          adress = value;
                          return null;
                        }
                      }),
                  const SizedBox(height: 20),
                  Text("Upload a image:"),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              gotoUpload(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Upload from camera")),
                      ),
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              gotoUpload(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Upload from Gallery")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            Box<Studentlist> box2 = Hive.box("Box");
            box2.add(Studentlist(
                name: name,
                phone: phone,
                subject: subject,
                address: adress,
                image: imageOn?.path != null ? imageOn!.path : null));

            Navigator.of(context).pop();
          } else {
            // print(imageOn!.path);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Future<void> gotoUpload(ImageSource source) async {
    final XFile? Picked = await ImageOf.pickImage(source: source);
    if (Picked == null) {
      return;
    } else {
      setState(() {
        imageOn = Picked;
      });
    }
  }
}
