// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studentlist/adapters/studentlist.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:studentlist/screenone.dart';

// import 'adapters/studentlist.dart';

class screen_show extends StatelessWidget {
  final String? name, sub, phone, adress, image;
  // int? ind;

  screen_show(
      {Key? key, this.name, this.sub, this.phone, this.adress, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Studentlist? obj3 = Hive.box<Studentlist>("Box").getAt(ind!);

    return Scaffold(
        appBar: AppBar(
          title: Text(name!),
        ),
        backgroundColor: Color.fromARGB(255, 202, 213, 221),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: image != null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(File(image!)),
                      )
                    : CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.amber,
                      ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "Name :",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(name!,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    const Divider(),
                    const Text(
                      "Phone :",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(phone!,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    Divider(),
                    const Text(
                      "Subject :",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(sub!,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    Divider(),
                    const Text(
                      "Address :",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(adress!,
                        style: TextStyle(
                          fontSize: 20,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
