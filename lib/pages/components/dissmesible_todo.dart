import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/pages/components/container_with_icon.dart';
import 'package:todolist_for_fittin/pages/components/todo_filling.dart';

import '../../modelview/app_provider.dart';

class DismissibleTodo extends StatelessWidget {
  const DismissibleTodo({
    super.key,
    required this.todoJob,
  });

  final TodoJob todoJob;

  @override
  Widget build(BuildContext context) {
    var nonListenProvider = Provider.of<AppProvider>(context, listen: false);
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          nonListenProvider.removeTodoJob(todoJob);
        }
        if (direction == DismissDirection.startToEnd) {}
      },
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          nonListenProvider.changeTodoJobStatus(todoJob, true);
          return false;
        } else {
          return true;
        }
      },
      secondaryBackground: ContainerWithIcon(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error,
        icon: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      background: ContainerWithIcon(
        alignment: Alignment.centerLeft,
        color: Theme.of(context).colorScheme.secondary,
        icon: Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      child: TodoFilling(todoJob: todoJob),
    );
  }
}
