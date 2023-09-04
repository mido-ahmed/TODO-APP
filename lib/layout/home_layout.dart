import 'package:flutter/material.dart';
import 'package:todo_list_app/modules/archived_tasks/app-archieved-tasks.dart';
import 'package:todo_list_app/modules/done_tasks/app-done-tasks.dart';
import 'package:todo_list_app/modules/new_tasks/app-new-tasks.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = const [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchieveTaskScreen()
  ];
  List<String> appBarNames = ["New Task", "Done Task", "Archive Task"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getName().then((value) {
            print(value);
          }).catchError((error) {
            print("Error is ${error.toString()}");
          });
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(appBarNames[currentIndex]),
        centerTitle: true,
      ),
      body: screens[currentIndex],
    );
  }

  Future<String> getName() async {
    return "Mohamed Ahmed";
  }
}
