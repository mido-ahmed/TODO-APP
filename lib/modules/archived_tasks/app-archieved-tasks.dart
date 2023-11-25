import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/constatnt/widgets/tasks_builder.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';

class ArchieveTaskScreen extends StatefulWidget {
  const ArchieveTaskScreen({super.key});

  @override
  State<ArchieveTaskScreen> createState() => _ArchieveTaskScreenState();
}

class _ArchieveTaskScreenState extends State<ArchieveTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archiveTasks;
        return taskBuilder(tasks: tasks);
      },
    );
  }
}
