import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/modelview/app_provider.dart';

class ChangeTodoPage extends StatefulWidget {
  final TodoJob? todoJob;

  const ChangeTodoPage({Key? key, required this.todoJob}) : super(key: key);

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
                      text: textFieldController.text, deadline: pickedDate);
                  Navigator.of(context).maybePop(todo);
                  // Navigator.pop(context);
                }
              },
            )
          ],
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Card(
                margin: EdgeInsets.zero,
                child: TextField(
                  maxLines: 6,
                  textCapitalization: TextCapitalization.sentences,
                  controller: textFieldController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Место для ваших заметок',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                )),
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
                value: pickedDate != null ? true : false,
                onChanged: (_) {
                  selectDate(context);
                }),
            InkWell(
              onTap: () {
                Navigator.of(context).maybePop(widget.todoJob);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Удалить',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
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
