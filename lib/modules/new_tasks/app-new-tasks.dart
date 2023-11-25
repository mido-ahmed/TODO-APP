import 'package:flutter/material.dart';
import 'package:todo_list_app/constatnt/widgets/tasks_builder.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}
