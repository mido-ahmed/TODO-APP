import 'package:flutter/material.dart';
import 'package:todo_list_app/modules/counter_screen/counter_cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      CounterCubit.get(context).minus();
                    },
                    child: const Text("Minus"),
                  ),
                  Text(
                    "${CounterCubit.get(context).counter}",
                    style: const TextStyle(fontSize: 60, color: Colors.black),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: const Text("Plus"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
