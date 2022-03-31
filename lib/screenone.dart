// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import 'package:studentlist/adapters/studentlist.dart';
import 'package:studentlist/screen_Edit.dart';
import 'package:studentlist/screen_add.dart';
import 'package:studentlist/screen_show.dart';

class screenOne extends StatefulWidget {
  const screenOne({
    Key? key,
  }) : super(key: key);

  @override
  State<screenOne> createState() => _screenOneState();
}

// ignore: camel_case_types
class _screenOneState extends State<screenOne> {
  String? nameAdd;
  List<Studentlist>? list2;
  String? imageAdd;

  String valuetext = '';

  bool clicksearch = true;
  UniqueKey key = UniqueKey();

  // String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: openSearch(),

        backgroundColor: Colors.green,
        shadowColor: Colors.black,
        // centerTitle: true,

        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  clicksearch = !clicksearch;
                  valuetext = '';
                });
              },
              icon: clicksearch ? Icon(Icons.search) : Icon(Icons.clear)),
        ],
        title: clicksearch
            ? Text("Home")
            : TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    hintText: 'Search Name',
                    hintStyle: TextStyle(color: Colors.white)),
                // controller: valuetext,
                onChanged: (value) {
                  setState(() {
                    valuetext = value;
                  });
                },
              ),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: Hive.box<Studentlist>("Box").listenable(),
        builder: (context, Box<Studentlist> box1, widget) {
          final list = box1.keys.toList();
          // list2 = list;
          if (list.isEmpty) {
            return Center(
              child: Text("No data available"),
            );
          } else {
            List<Studentlist> data = box1.values
                .where((element) => element.name!
                    .toLowerCase()
                    .contains(valuetext.toLowerCase()))
                .toList();
            if (data.isEmpty) {
              return Center(child: Text("No data available"));
            }

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  itemExtent: 80,
                  itemBuilder: (context, index) {
                    imageAdd = data[index].image;

                    nameAdd = data[index].name;

                    return Card(
                      key: key,
                      child: ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => screen_show(
                            name: data[index].name,
                            sub: data[index].subject,
                            adress: data[index].address,
                            phone: data[index].phone,
                            image: data[index].image,
                          ),
                        )),
                        // minLeadingWidth: 50,
                        title: Text(nameAdd!),

                        leading: imageAdd != null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    FileImage(File(imageAdd.toString())),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                    Color.fromARGB(255, 109, 102, 102),
                              ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  // print(list1);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => screenedit(
                                      name1: data[index].name,
                                      sub1: data[index].subject,
                                      phone1: data[index].phone,
                                      adress1: data[index].address,
                                      imag: data[index].image,
                                      key1: data,
                                      inde: data[index].key,
                                    ),
                                  ));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Delete'),
                                            content: Text('Delete the Contact'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  data[index].delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("ok"),
                                              ),
                                            ],
                                          ));
                                  //
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                        // onTap: Gotopage(),
                      ),
                    );
                  },
                  // separatorBuilder: (context, index) {
                  //   return
                  // },
                  itemCount: data.length),
            );
            // }
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => screenAdd()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  searchfield(String query) {
    // setState(() {});
  }
  // deleting(BuildContext context) {}
}
