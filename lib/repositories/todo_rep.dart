import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_for_fittin/model/todo_job.dart';

class TodoRepository {
  final Map<int, TodoJob> _todoJobs = {};

  // нужна ли нам мапа, если у нас итак бд
  // чисто в теории так быстрее и, если у нас отвалится бд/бек,
  // то какие-то кешированные данные у нас будут

  static TodoRepository? _instance;

  Database? _database;

  factory TodoRepository() {
    return _instance ??= TodoRepository._();
  }

  Future<void> init() async {
    _database = await openDatabase(
      'todo.db',
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE todo(id INTEGER PRIMARY KEY, text TEXT, deadline TEXT, done BOOLEAN )');
      },
    );
    await loadTodoJobs();
    // AppProvider().loadTodoJobsFromShared();
  }

  TodoRepository._();

  int countDone() => _todoJobs.values.where((todo) => todo.done).length;

  List<TodoJob> getNotDone() =>
      _todoJobs.values.where((todo) => !todo.done).toList();

  List<TodoJob> getAll() => _todoJobs.values.toList();

  Future<void> loadTodoJobs() async {
    getAllTodoJobFromDB().then((value) => _todoJobs.addAll({
          for (var todo in value)
            todo.id ?? DateTime.now().microsecondsSinceEpoch: todo
        }));
  }


  Future<void> saveTodoJobIntoDB(TodoJob todoJob) async {
    await _database?.insert('todo', TodoJob.toJson(todoJob),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTodoJobIntoDB(TodoJob todoJob) async {
    await _database?.update('todo', TodoJob.toJson(todoJob),
        where: 'id = ?', whereArgs: [todoJob.id]);
  }

  Future<void> removeTodoJobFromDB(TodoJob todoJob) async {
    await _database?.delete('todo', whereArgs: [todoJob.id], where: 'id = ?');
  }

  void saveTodoJob(TodoJob todoJob) {
    int? todoId = todoJob.id;
    if (todoId == null) {
      int id = DateTime.now().microsecondsSinceEpoch;
      var newTodoJob = todoJob.copyWith(id: id);
      _todoJobs[id] = newTodoJob;
      saveTodoJobIntoDB(newTodoJob);
    } else {
      _todoJobs[todoId] = todoJob;
      updateTodoJobIntoDB(todoJob);
    }
  }

  void removeTodoJob(TodoJob todoJob) {
    _todoJobs.remove(todoJob.id);
    removeTodoJobFromDB(todoJob);
  }

  Future<List<TodoJob>> getAllTodoJobFromDB() async {
    final List<Map<String, dynamic>> maps =
        await _database?.query('todo') ?? [];
    return List.generate(maps.length, (index) => TodoJob.fromJson(maps[index]));
  }
}
