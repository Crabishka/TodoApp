import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/modelview/app_provider.dart';
import 'package:todolist_for_fittin/pages/add_todo_page/change_todo_page.dart';
import 'package:todolist_for_fittin/pages/components/formatted_date_text.dart';
import 'package:todolist_for_fittin/repositories/todo_rep.dart';

class TodoFilling extends StatelessWidget {
  const TodoFilling({
    super.key,
    required this.todoJob,
  });

  final TodoJob todoJob;

  @override
  Widget build(BuildContext context) {
    var nonListenProvider = Provider.of<AppProvider>(context, listen: false);
    var theme = Theme.of(context);
    return Row(
      children: [
        Checkbox(
            value: todoJob.done,
            onChanged: (value) {
              nonListenProvider.changeTodoJobStatus(todoJob, value);
            }),
        Expanded(
          child: InkWell(
            child: ListTile(
              title: Text(
                todoJob.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyLarge,
              ),
              subtitle: todoJob.deadline != null
                  ? FormattedDataText(date: todoJob.deadline!)
                  : null,
            ),
            onTap: () async {
              var dialogTodo = await Navigator.push(
                  context,
                  MaterialPageRoute<TodoJob?>(
                      builder: (_) => ChangeTodoPage(
                            todoJob: todoJob,
                          )));
              if (dialogTodo == null) {
                nonListenProvider.removeTodoJob(todoJob);
              } else {
                nonListenProvider.addTodoJob(dialogTodo);
              }
            },
          ),
        ),
      ],
    );
  }
}
