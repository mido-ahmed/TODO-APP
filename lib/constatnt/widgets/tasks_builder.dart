import 'package:flutter/material.dart';
import 'package:todo_list_app/constatnt/widgets/taskItem.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

Widget taskBuilder({required List<Map<String, Object?>> tasks}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => BuildTaskItem(
                model: tasks[index],
                context: context,
              ),
          separatorBuilder: (context, index) => Container(
              width: double.infinity, height: 1.0, color: Colors.grey),
          itemCount: tasks.length),
      fallback: (context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu, color: Colors.grey, size: 100.0),
            Text(
              "No Tasks Yet , Please Add Some Tasks",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
