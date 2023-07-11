import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/modelview/app_provider.dart';
import 'package:todolist_for_fittin/pages/add_todo_page/add_todo_page.dart';
import 'package:todolist_for_fittin/pages/add_todo_page/change_todo_page.dart';
import 'package:todolist_for_fittin/pages/components/list_of_todo_tile.dart';

class MainTodoPage extends StatelessWidget {
  const MainTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final data = Provider.of<AppProvider>(context).getTodoJobs();
    final status = Provider.of<AppProvider>(context).isFinishedShowed;
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
              ListStatusRow(),
              Expanded(
                child: ListOfTodoTile(todoJobs: data),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTodoPage()));
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}

class ListStatusRow extends StatelessWidget {
  const ListStatusRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        Text(
          "Выполнено - ${Provider.of<AppProvider>(context, listen: false).getNumberOfFinishedTask()}",
          style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.tertiary, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false)
                  .changeShowedStatus();
            },
            icon: Icon(
              Provider.of<AppProvider>(context).isFinishedShowed
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: theme.colorScheme.secondary,
            ))
      ],
    );
  }
}

class ContainerWithIcon extends StatelessWidget {
  const ContainerWithIcon({
    this.color = Colors.red,
    required this.icon,
    super.key,
    this.alignment = Alignment.centerLeft,
  });

  final Color color;
  final Icon icon;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: icon,
      ),
    );
  }
}
