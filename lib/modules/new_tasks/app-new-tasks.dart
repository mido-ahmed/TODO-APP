import 'package:flutter/material.dart';

import '../../constatnt/widgets/constatnts.dart';
import '../../constatnt/widgets/taskItem.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => BuildTaskItem(
              model: tasks[index],
            ),
        separatorBuilder: (context, index) =>
            Container(width: double.infinity, height: 1.0, color: Colors.grey),
        itemCount: tasks.length);
  }
}
