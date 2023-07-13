import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/modelview/app_provider.dart';

import 'package:todolist_for_fittin/pages/add_todo_page/change_todo_page.dart';
import 'package:todolist_for_fittin/pages/components/list_of_todo_tile.dart';
import 'package:todolist_for_fittin/pages/components/list_status_row.dart';

class MainTodoPage extends StatelessWidget {
  const MainTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = Provider.of<AppProvider>(context);
    final data = provider.getTodoJobs();
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: themeData.colorScheme.background,
        centerTitle: true,
        title: Text(
          'Мои дела',
          style: themeData.textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              const ListStatusRow(),
              Expanded(
                child: ListOfTodoTile(
                  todoJobs: data,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () async {
          var dialogTodo = await Navigator.push(
              context,
              MaterialPageRoute<TodoJob?>(
                  builder: (context) => const ChangeTodoPage()));
          if (dialogTodo != null) {
            provider.addTodoJob(dialogTodo);
          }
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
