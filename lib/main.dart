import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/modelview/AppState.dart';

import 'package:todolist_for_fittin/todo_app.dart';

final GetIt getIt = GetIt.instance;

void main() {
  runApp(ChangeNotifierProvider(create: (_) => AppState.instance, child: TodoApp()));
}
