import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constatnt/widgets/taskItem.dart';

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
        return ListView.separated(
            itemBuilder: (context, index) => BuildTaskItem(
                  model: AppCubit.get(context).tasks[index],
                ),
            separatorBuilder: (context, index) => Container(
                width: double.infinity, height: 1.0, color: Colors.grey),
            itemCount: AppCubit.get(context).tasks.length);
      },
    );
  }
}
