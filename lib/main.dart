import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:todolist_for_fittin/modelview/app_provider.dart';
import 'package:todolist_for_fittin/repositories/todo_rep.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_for_fittin/todo_app.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  await TodoRepository().init();


  runApp(ChangeNotifierProvider(
      create: (_) => AppProvider.instance, child: const TodoApp()));
  // await AppState.instance.loadTodoJobsFromShared();
}
