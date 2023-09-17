import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';
import '../constatnt/widgets/InsertDataWidget.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                if (AppCubit.get(context).isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context).insertToDataBase(
                      titleController.text,
                      timeController.text,
                      dateController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                            color: Colors.white,
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
                    AppCubit.get(context).changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  AppCubit.get(context)
                      .changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(AppCubit.get(context).fabIcon, size: 30.0),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.teal,
              selectedItemColor: Colors.white,
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
                backgroundColor: Colors.teal,
                title: Text(cubit.appBarNames[cubit.currentIndex]),
                centerTitle: true),
            body: state is AppGetDataBaseLoadingState
                ? const Center(child: CircularProgressIndicator(color: Colors.teal))
                : AppCubit.get(context).screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
