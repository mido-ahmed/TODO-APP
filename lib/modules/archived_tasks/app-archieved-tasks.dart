import 'package:flutter/material.dart';

class ArchieveTaskScreen extends StatefulWidget {
  const ArchieveTaskScreen({super.key});

  @override
  State<ArchieveTaskScreen> createState() => _ArchieveTaskScreenState();
}

class _ArchieveTaskScreenState extends State<ArchieveTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Archieved Task Screen",
      style: TextStyle(fontSize: 30),
    ));
  }
}
