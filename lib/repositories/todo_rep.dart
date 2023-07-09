import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/modelview/AppState.dart';

import 'dart:convert';

class TodoRepository {
  void saveTodoJobIntoSharedPreference(TodoJob todoJob) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoJobs = prefs.getStringList('todoJobs') ?? [];
    todoJobs.add(json.encode(TodoJob.toJson(todoJob)));
    prefs.setStringList('todoJobs', todoJobs);
  }

  Future<List<TodoJob>> getTodoJobsFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoJobs = prefs.getStringList('todoJobs') ?? [];
    List<TodoJob> result =
        todoJobs.map((e) => TodoJob.fromJson(json.decode(e))).toList();
    return result;
  }
}
