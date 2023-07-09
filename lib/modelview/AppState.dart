import 'package:flutter/cupertino.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';
import 'package:todolist_for_fittin/repositories/todo_rep.dart';

class AppState extends ChangeNotifier {
  AppState._();

  List<TodoJob> _todoJobs = [];
  bool isFinishedShowed = true;

  static final instance = AppState._();

  int getNumberOfFinishedTask() {
    return _todoJobs.where((element) => element.done).toList().length;
  }

  void addTodoJob(TodoJob todoJob) {
    _todoJobs.add(todoJob);
    notifyListeners();
  }

  void changeShowedStatus() {
    isFinishedShowed = !isFinishedShowed;
    notifyListeners();
  }

  void removeTodoJob(int index) {
    _todoJobs.removeAt(index);
    notifyListeners();
  }

  void removeTodoJobByObject(TodoJob todoJob) {
    _todoJobs.remove(todoJob);
    notifyListeners();
  }

  void changeTodoJobStatus(int index, bool? value) {
    _todoJobs[index] = _todoJobs[index].copyWith(done: value ?? false);
    notifyListeners();
  }

  TodoJob getTodoJobById(){

  }

  void changeTodoJobStatusByObject(TodoJob todoJob, bool? value) {
    var newTodoJob = todoJob.copyWith(done: value ?? false);
    _todoJobs[_todoJobs.indexOf(todoJob)] = newTodoJob;

    // _todoJobs.g = _todoJobs[index].copyWith(done: value ?? false);
    notifyListeners();
  }

  List<TodoJob> getTodoJobs() {
    return _todoJobs;
  }

  Future<void> loadTodoJobsFromShared() async {
    TodoRepository()
        .getTodoJobsFromSharedPreference()
        .then((value) => _todoJobs = value);
    notifyListeners();
  }
}
