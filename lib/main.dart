import 'package:flutter/material.dart';
import 'package:todo_list_app/layout/home_layout.dart';
import 'package:bloc/bloc.dart';
import 'constatnt/bloc_observer/bloc_observer.dart';
import 'modules/counter_screen/counter.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData.dark().copyWith(),
      home: SafeArea(
        child: CounterScreen(),
      ),
    );
  }
}
