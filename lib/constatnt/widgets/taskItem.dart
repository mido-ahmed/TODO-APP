import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';

class BuildTaskItem extends StatelessWidget {
  final Map<String, Object?> model;

  const BuildTaskItem({super.key, required this.model, context});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model["id"].toString()),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model["id"] as int);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
            height: MediaQuery.sizeOf(context).height * 0.08800,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Center(
                    child: Text(
                      '${model['time']}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${model['title']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text(
                        '${model['date']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).updateData(
                          status: "done",
                          id: model['id'] as int,
                        );
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).updateData(
                          status: "archive",
                          id: model['id'] as int,
                        );
                      },
                      icon: const Icon(
                        Icons.archive,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
