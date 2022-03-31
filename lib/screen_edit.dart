import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentlist/adapters/studentlist.dart';
import 'package:studentlist/screen_show.dart';
import 'package:studentlist/screenone.dart';

// ignore: camel_case_types
class screenedit extends StatefulWidget {
  final List<Studentlist>? key1;
  final String? name1, sub1, phone1, adress1;
  screenedit(
      {Key? key,
      this.imag,
      this.name1,
      this.sub1,
      this.phone1,
      this.adress1,
      required this.key1,
      this.inde})
      : super(key: key);
  final int? inde;
  final String? imag;
  @override
  State<screenedit> createState() => _screenAddState();
}

class _screenAddState extends State<screenedit> {
  final _formkey = GlobalKey<FormState>();

  String? name;
  String? phone;
  String? adress;
  String? subject;
  String? imageOn;
  int? accesskey;

  @override

  // String? file = File(imageOn!.path);
  final ImagePicker ImageOf = ImagePicker();
  int? newkey;
  // String pattern = ;
  RegExp regExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

  @override
  Widget build(BuildContext context) {
    // Box<Studentlist> box3 = Hive.box("Box");
    // newkey = widget.key1![widget.inde].key;
    // List<Studentlist> studentlist = box3.values.toList();
    // for (var i = 0; i < studentlist.length; i++) {
    //   if (studentlist[i].key == newkey) {
    //     accesskey = i;
    //     break;
    //   }
    // }
    String? name2 = widget.name1;
    String? sub2 = widget.sub1;
    String? phone2 = widget.phone1;
    String? address2 = widget.adress1;
    String? image2 = widget.imag;
    int? index = widget.inde;

    // Studentlist? obj1 = box3.getAt(index);
    if (imageOn != null) {
      setState(() {
        image2 = imageOn;
      });
    }

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
                  image2 != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(File(image2!)),
                        )
                      : CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.red,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      initialValue: name2,
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
                      initialValue: phone2,
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
                      initialValue: sub2,
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
                      initialValue: address2,
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
                              // if(obj1.image !=null)
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
            box2.putAt(
                index!,
                Studentlist(
                    name: name,
                    phone: phone,
                    subject: subject,
                    address: adress,
                    image: image2));

            Navigator.of(context).pop();
          } else {
            // print(index);
          }
        },
        child: Icon(Icons.save_alt),
      ),
    );
  }

  Future<void> gotoUpload(ImageSource source) async {
    final XFile? Picked = await ImageOf.pickImage(source: source);
    if (Picked == null) {
      return;
    } else {
      setState(() {
        imageOn = Picked.path;
      });
    }
  }
}
