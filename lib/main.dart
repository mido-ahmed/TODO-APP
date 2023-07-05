import 'package:flutter/material.dart';
import 'package:todo_list_app/layout/home_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator App',
      theme: ThemeData.dark().copyWith(
          // primaryColor: const Color(0xFF3D4149),
          // scaffoldBackgroundColor: const Color(0xFF3D4149),
          ),
      home: SafeArea(
        child: HomeLayout(),
      ),
    );
  }
}
