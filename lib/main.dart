import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentlist/adapters/studentlist.dart';
import 'package:studentlist/screenone.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentlistAdapter());
  await Hive.openBox<Studentlist>("Box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: screenOne(),
    );
  }
}
