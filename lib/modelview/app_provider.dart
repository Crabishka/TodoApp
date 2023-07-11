import 'package:flutter/cupertino.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/repositories/todo_rep.dart';

class AppProvider extends ChangeNotifier {
  static AppProvider? _instance;

  factory AppProvider() {
    return _instance ??= AppProvider._();
  }

  AppProvider._();

  bool isFinishedShowed = true;

  static final instance = AppProvider._();

  int getNumberOfFinishedTask() {
    return TodoRepository().countDone();
  }

  void addTodoJob(TodoJob todoJob) {
    TodoRepository().saveTodoJob(todoJob);
    notifyListeners();
  }

  void changeTodoJob(TodoJob newTodoJob) {
    TodoRepository().saveTodoJob(newTodoJob);
    notifyListeners();
  }

  void changeShowedStatus() {
    isFinishedShowed = !isFinishedShowed;
    notifyListeners();
  }

  void removeTodoJob(TodoJob todoJob) {
    TodoRepository().removeTodoJob(todoJob);
    notifyListeners();
  }

  void changeTodoJobStatus(TodoJob todoJob, bool? value) {
    TodoJob newTodoJob = todoJob.copyWith(done: value ?? false);
    TodoRepository().saveTodoJob(todoJob);
    notifyListeners();
  }

  List<TodoJob> getTodoJobs() {
    return TodoRepository().getAll();
  }
}