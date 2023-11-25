import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/modules/done_tasks/app-done-tasks.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archived_tasks/app-archieved-tasks.dart';
import '../../modules/new_tasks/app-new-tasks.dart';

part 'home_layout_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  Database? database;
  int currentIndex = 0;
  IconData fabIcon = Icons.edit;
  List<Map<String, Object?>> newTasks = [];
  List<Map<String, Object?>> doneTasks = [];
  List<Map<String, Object?>> archiveTasks = [];
  List<Widget> screens = const [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchieveTaskScreen()
  ];
  List<String> appBarNames = ["New Task", "Done Task", "Archive Task"];
  bool isBottomSheetShown = false;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDataBase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print("database created");
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER primary key,title TEXT,date TEXT,time TEXT ,status TEXT);')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("Error when creating table ${error.toString()}");
        });
      },
      onOpen: (database) {
        getFromDataBase(database);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertToDataBase(
    @required String title,
    @required String date,
    @required String time,
  ) async {
    await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        log("$value inserted successfully");
        emit(AppInsertDataBaseState());
        getFromDataBase(database);
      }).catchError((error) {
        log("Error when inserting new record ${error.toString()}");
      });
      return null;
    });
  }

  void getFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element["status"] == "new") {
          newTasks.add(element);
        } else if (element["status"] == "done") {
          doneTasks.add(element);
        } else if (element["status"] == "archive") {
          archiveTasks.add(element);
        }
      });
      emit(AppGetDataBaseState());
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database?.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ["$status", id],
    ).then((value) {
      getFromDataBase(database);
      emit(AppUpdateBottomSheetState());
    }).catchError((error) {
      log("Error when updating record ${error.toString()}");
    });
  }

  void deleteData({
    required int id,
  }) async {
    database?.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getFromDataBase(database);
      emit(AppDeleteDataBaseState());
    }).catchError((error) {
      log("Error when deleting record ${error.toString()}");
    });
  }

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
