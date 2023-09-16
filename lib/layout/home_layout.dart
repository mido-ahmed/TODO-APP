import 'package:flutter/material.dart';
import 'package:todo_list_app/modules/archived_tasks/app-archieved-tasks.dart';
import 'package:todo_list_app/modules/done_tasks/app-done-tasks.dart';
import 'package:todo_list_app/modules/new_tasks/app-new-tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';
import '../constatnt/widgets/InsertDataWidget.dart';
import '../constatnt/widgets/constatnts.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  IconData fabIcon = Icons.edit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    insertToDataBase(
                      titleController.text,
                      timeController.text,
                      dateController.text,
                    ).then((value) {
                      getFromDataBase(database).then((value) {
                        Navigator.pop(context);
                        // setState(() {
                        //   isBottomSheetShown = false;
                        //   fabIcon = Icons.edit;
                        //   tasks = value!;
                        // });
                        print(tasks);
                      });
                    });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                            color: Colors.grey,
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                                key: formKey,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InsertDataWidget(
                                          keyboardType: TextInputType.text,
                                          controller: titleController,
                                          iconData: Icons.title,
                                          borderColor: Colors.black,
                                          borderWidth: 3,
                                          hintText: "Task Time",
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "title must not be empty";
                                            } else {
                                              return null;
                                            }
                                          }),
                                      TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.black)),
                                              label: Text("Task Time",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              prefixIcon: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: Colors.black)),
                                          controller: timeController,
                                          keyboardType: TextInputType.datetime,
                                          onTap: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              timeController.text = value!
                                                  .format(context)
                                                  .toString();
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "time must not be empty";
                                            }
                                            return null;
                                          }),
                                      const SizedBox(height: 15.0),
                                      TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.black)),
                                              label: Text("Task Date",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              prefixIcon: Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Colors.black)),
                                          controller: dateController,
                                          keyboardType: TextInputType.datetime,
                                          onTap: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.parse(
                                                        "2030-12-30"))
                                                .then((value) {
                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value!);
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "date must not be empty";
                                            }
                                            return null;
                                          })
                                    ]))),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    isBottomSheetShown = false;
                    // setState(() {
                    //   fabIcon = Icons.edit;
                    // });
                  });
                  isBottomSheetShown = true;
                  // setState(() {
                  //   fabIcon = Icons.add;
                  // });
                }
              },
              child: Icon(fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: "Archive"),
              ],
            ),
            appBar: AppBar(
                title: Text(cubit.appBarNames[cubit.currentIndex]),
                centerTitle: true),
            body: tasks.length == 0
                ? const Center(child: CircularProgressIndicator())
                : AppCubit.get(context).screens[cubit.currentIndex],
          );
        },
      ),
    );
  }

  Database? database;

  void createDataBase() async {
    database = await openDatabase(
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
        getFromDataBase(database).then((value) {
          // setState(() {
          //   tasks = value!;
          // });
          print(tasks);
        });
        print("database opened");
      },
    );
  }

  Future insertToDataBase(
    @required String title,
    @required String date,
    @required String time,
  ) async {
    return await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print("$value inserted successfully");
      }).catchError((error) {
        print("Error when inserting new record ${error.toString()}");
      });
      return null;
    });
  }

  Future<List<Map<String, Object?>>?> getFromDataBase(database) async {
    return await database?.rawQuery('SELECT * FROM tasks');
  }
}
