import 'package:flutter/material.dart';
import 'package:todo_list_app/constatnt/widgets/tasks_builder.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTaskScreen extends StatefulWidget {
  const DoneTaskScreen({super.key});

  @override
  State<DoneTaskScreen> createState() => _DoneTaskScreenState();
}

class _DoneTaskScreenState extends State<DoneTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}
