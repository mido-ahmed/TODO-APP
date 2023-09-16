import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/modules/done_tasks/app-done-tasks.dart';

import '../../modules/archived_tasks/app-archieved-tasks.dart';
import '../../modules/new_tasks/app-new-tasks.dart';

part 'home_layout_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = const [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchieveTaskScreen()
  ];
  List<String> appBarNames = ["New Task", "Done Task", "Archive Task"];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}
