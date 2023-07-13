import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/modelview/app_provider.dart';
import 'package:todolist_for_fittin/pages/components/delete_tile.dart';
import 'package:todolist_for_fittin/pages/components/todo_text_field.dart';

class ChangeTodoPage extends StatefulWidget {
  final TodoJob? todoJob;

  const ChangeTodoPage({Key? key, this.todoJob}) : super(key: key);

  @override
  State<ChangeTodoPage> createState() => _ChangeTodoPageState();
}

class _ChangeTodoPageState extends State<ChangeTodoPage> {
  TextEditingController textFieldController = TextEditingController();
  bool isDeadlineExist = true;
  DateTime? pickedDate;

  @override
  void initState() {
    super.initState();
    textFieldController.text = widget.todoJob?.text ?? '';
    pickedDate = widget.todoJob?.deadline;
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            TextButton(
              child: Text("СОХРАНИТЬ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
              onPressed: () {
                if (textFieldController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Ваша заметка пуста')));
                } else {
                  final todo = widget.todoJob?.copyWith(
                          text: textFieldController.text,
                          deadline: pickedDate) ??
                      TodoJob(text: textFieldController.text,
                      deadline: pickedDate);
                  Navigator.of(context).maybePop(todo);
                }
              },
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).maybePop(widget.todoJob);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TodoTextField(textFieldController: textFieldController),
            const SizedBox(
              height: 16,
            ),
            CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Дедлайн',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: pickedDate != null
                    ? Text(
                        DateFormat('dd-MMM-yyyy').format(pickedDate!),
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : null,
                value: pickedDate != null,
                onChanged: (_) {
                  selectDate(context);
                }),
            if (widget.todoJob != null)
            const DeleteTile()
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: pickedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != pickedDate) {
      setState(() {
        pickedDate = picked;
      });
    }
  }
}




