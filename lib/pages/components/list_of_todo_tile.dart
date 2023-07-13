import 'package:flutter/material.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/pages/components/dissmesible_todo.dart';

class ListOfTodoTile extends StatelessWidget {
  final List<TodoJob> todoJobs;

  const ListOfTodoTile({
    Key? key,
    required this.todoJobs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoJobs.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: getBorderGeometry(index, todoJobs.length)),
          margin: EdgeInsets.zero,
          child: DismissibleTodo(todoJob: todoJobs[index]),
        );
      },
    );
  }

  BorderRadiusGeometry getBorderGeometry(int index, int max) {
    if (max - 1 == 0) {
      return const BorderRadius.all(Radius.circular(8));
    }
    if (index == 0) {
      return const BorderRadius.vertical(top: Radius.circular(8));
    }
    if (index == max - 1) {
      return const BorderRadius.vertical(bottom: Radius.circular(8));
    } else {
      return const BorderRadius.all(Radius.zero);
    }
  }
}
