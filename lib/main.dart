import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:task_management/home_page.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper initialization

  /// Initialize Hive
  ///await Hive.initFlutter();

  ///Opening a box
  await Hive.openBox('myBox');

  ///Run main method
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: HomePage(),
    );
  }
}

