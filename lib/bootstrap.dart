import 'package:flutter/material.dart';

// Packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_api/todos_api.dart';

// Project
import 'package:todone/views/app/app.dart';
import 'package:todone/views/onboarding/onboarding.dart';

void bootstrap({
  required SharedPreferences plugin,
  required TodosApi todosApi,
}) {
  Bloc.observer = const AppBlocObserver();

  runApp(TodoneApp(
    plugin: plugin,
    todosApi: todosApi,
  ));
}
