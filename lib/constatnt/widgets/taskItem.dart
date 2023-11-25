import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/home_layout_cubit/home_layout_cubit.dart';

class BuildTaskItem extends StatefulWidget {
  final Map<String, Object?> model;

  const BuildTaskItem({super.key, required this.model, context});

  @override
  State<BuildTaskItem> createState() => _BuildTaskItemState();
}

class _BuildTaskItemState extends State<BuildTaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
          height: MediaQuery.sizeOf(context).height * 0.08800,
          width: double.infinity,
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
                    '${widget.model['time']}',
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
                      '${widget.model['title']}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Text(
                      '${widget.model['date']}',
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
                        id: widget.model['id'] as int,
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
                        id: widget.model['id'] as int,
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
    );
  }
}
