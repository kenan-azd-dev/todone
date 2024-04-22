import 'package:flutter/material.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todone/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  final todosApi = await LocalStorageTodosApi.create();

  bootstrap(
    plugin: sharedPreferences,
    todosApi: todosApi,
  );
}
