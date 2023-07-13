import 'package:flutter/material.dart';

class TodoTextField extends StatelessWidget {
  const TodoTextField({
    super.key,
    required this.textFieldController,
  });
  final TextEditingController textFieldController;

  @override
  Widget build(BuildContext context) {
    return Card(
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
        ));
  }
}
