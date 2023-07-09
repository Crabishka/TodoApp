import 'package:flutter/cupertino.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/repositories/todo_rep.dart';

class AppState extends ChangeNotifier {
  AppState._();

  List<TodoJob> _todoJobs = [];

  Future<void> loadTodoJobsFromShared() async {
    await TodoRepository()
        .getTodoJobsFromSharedPreference()
        .then((value) => _todoJobs = value);
    notifyListeners();
  }

  bool isFinishedShowed = true;

  static final instance = AppState._();

  int getNumberOfFinishedTask() {
    return _todoJobs.where((element) => element.done).toList().length;
  }

  void addTodoJob(TodoJob todoJob) {
    _todoJobs.add(todoJob);
    TodoRepository().saveTodoJobIntoSharedPreference(todoJob);
    notifyListeners();
  }

  void changeTodoJob(int index, TodoJob newTodoJob) {
    _todoJobs[index] = newTodoJob;
    TodoRepository().updateTodoJobIntoSharedPreference(index, newTodoJob);
    notifyListeners();
  }

  void changeShowedStatus() {
    isFinishedShowed = !isFinishedShowed;
    notifyListeners();
  }

  void removeTodoJob(int index) {
    _todoJobs.removeAt(index);
    TodoRepository().removeTodoJobFromSharedPreference(index);
    notifyListeners();
  }

  @deprecated
  void removeTodoJobByObject(TodoJob todoJob) {
    _todoJobs.remove(todoJob);
    notifyListeners();
  }

  void changeTodoJobStatus(int index, bool? value) {
    TodoJob newTodoJob = _todoJobs[index].copyWith(done: value ?? false);
    _todoJobs[index] = newTodoJob;
    TodoRepository().updateTodoJobIntoSharedPreference(index, newTodoJob);
    notifyListeners();
  }

  TodoJob getTodoJobById(int index) {
    return _todoJobs[index];
  }

  @deprecated
  void changeTodoJobStatusByObject(TodoJob todoJob, bool? value) {
    var newTodoJob = todoJob.copyWith(done: value ?? false);
    _todoJobs[_todoJobs.indexOf(todoJob)] = newTodoJob;
    notifyListeners();
  }

  List<TodoJob> getTodoJobs() {
    return _todoJobs;
  }
}
