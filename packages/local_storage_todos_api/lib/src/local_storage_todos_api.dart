import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos_api/todos_api.dart';
import 'package:path/path.dart';

/// {@template local_storage_todos_api}
/// A Flutter implementation of the [TodosApi] that uses local storage.
/// {@endtemplate}
class LocalStorageTodosApi extends TodosApi {
  LocalStorageTodosApi._create(Database db) {
    _db = db;
  }

  /// {@macro local_storage_todos_api}
  static Future<LocalStorageTodosApi> create() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todone-todos.db');
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
      CREATE TABLE IF NOT EXISTS $todosTableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        isCompleted INTEGER NOT NULL DEFAULT 0,
        dueDate INTEGER,
        dueTime INTEGER
      );
    ''');
    });

    final localStorageTodosApi = LocalStorageTodosApi._create(database);
    await localStorageTodosApi._init();
    return localStorageTodosApi;
  }

  late Database _db;

  final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(const []);

  /// The key used for storing the todos locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static String todosTableName = 'TODO';

  Future<List<Todo>> _getTodos() async => await _db
      .query(todosTableName)
      .then((maps) => maps.map((map) => Todo.fromMap(map)).toList());

  Future<void> _saveTodos(List<Todo> todos) async {
    await _db.delete(todosTableName);
    for (final todo in todos) {
      await _db.insert(todosTableName, todo.toMap());
    }
  }

  Future<void> _init() async {
    final todos = await _getTodos();
    _todoStreamController.add(todos);
  }

  @override
  Stream<List<Todo>> getTodos() => _todoStreamController.asBroadcastStream();

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == todo.id);
    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }
    await _saveTodos(todos);
    _todoStreamController.add(todos);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);
    if (todoIndex == -1) {
      throw TodoNotFoundException();
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      return await _saveTodos(todos);
    }
  }

  @override
  Future<int> clearCompleted() async {
    final todos = [..._todoStreamController.value];
    final completedTodosAmount = todos.where((t) => t.isCompleted).length;
    todos.removeWhere((t) => t.isCompleted);
    _todoStreamController.add(todos);
    await _saveTodos(todos);
    return completedTodosAmount;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final todos = [..._todoStreamController.value];
    final changedTodosAmount =
        todos.where((t) => t.isCompleted != isCompleted).length;
    final newTodos = [
      for (final todo in todos) todo.copyWith(isCompleted: isCompleted),
    ];
    _todoStreamController.add(newTodos);
    await _saveTodos(todos);
    return changedTodosAmount;
  }
}
