import 'package:flutter/material.dart';
import 'package:todo_list_app/modules/archived_tasks/app-archieved-tasks.dart';
import 'package:todo_list_app/modules/done_tasks/app-done-tasks.dart';
import 'package:todo_list_app/modules/new_tasks/app-new-tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../constatnt/widgets/InsertDataWidget.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  IconData fabIcon = Icons.edit;
  List<Widget> screens = const [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchieveTaskScreen()
  ];
  List<String> appBarNames = ["New Task", "Done Task", "Archive Task"];

  @override
  void initState() {
    super.initState();
    createDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertToDataBase(titleController.text, timeController.text,
                      dateController.text)
                  .then((value) {
                Navigator.pop(context);
                isBottomSheetShown = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              });
            }
          } else {
            scaffoldKey.currentState?.showBottomSheet(
              (context) => Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      key: formKey,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                                        width: 2, color: Colors.black)),
                                label: Text("Task Time",
                                    style: TextStyle(color: Colors.black)),
                                prefixIcon: Icon(Icons.watch_later_outlined,
                                    color: Colors.black)),
                            controller: timeController,
                            keyboardType: TextInputType.datetime,
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                timeController.text =
                                    value!.format(context).toString();
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
                                        width: 2, color: Colors.black)),
                                label: Text("Task Date",
                                    style: TextStyle(color: Colors.black)),
                                prefixIcon: Icon(Icons.calendar_month_outlined,
                                    color: Colors.black)),
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2030-12-30"))
                                  .then((value) {
                                dateController.text =
                                    DateFormat.yMMMd().format(value!);
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
            );
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: "Done"),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: "Archive"),
        ],
      ),
      appBar: AppBar(title: Text(appBarNames[currentIndex]), centerTitle: true),
      body: screens[currentIndex],
    );
  }
}

Database? database;

void createDataBase() async {
  database = await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (database, version) async {
      print("database craeted");
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
      print("database opened");
    },
  );
}

Future insertToDataBase(
  @required String title,
  @required String time,
  @required String date,
) async {
  return await database?.transaction((txn) async {
    txn
        .rawInsert(
            'INSERT INTO tasks(title,date,time,status) VALUES ("$title","$time","$date","new")')
        .then((value) {
      print("$value inserted successfully");
    }).catchError((error) {
      print("Error when inserting new record ${error.toString()}");
    });
    return null;
  });
}

void getFromDataBase() {}
