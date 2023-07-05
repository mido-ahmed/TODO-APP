import 'package:flutter/material.dart';

class DoneTaskScreen extends StatefulWidget {
  const DoneTaskScreen({super.key});

  @override
  State<DoneTaskScreen> createState() => _DoneTaskScreenState();
}

class _DoneTaskScreenState extends State<DoneTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Done Task Screen",
      style: TextStyle(fontSize: 30),
    ));
  }
}
