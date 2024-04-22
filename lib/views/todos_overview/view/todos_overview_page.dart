import 'dart:io';

import 'package:flutter/material.dart';

import 'package:todone/views/edit_todo/view/edit_todo_page.dart';

// Packages
import 'package:todos_repository/todos_repository.dart';

// Project
import 'package:todone/views/todos_overview/todos_overview.dart';

/// {@template todos_overview_page}
/// This page displays a list of todos, along with
/// a weekly view ([WeeklyCalendar]).
/// Also you can filter the todos using a drop down button.
/// {@endtemplate}
class TodosOverviewPage extends StatelessWidget {
  /// {@macro todos_overview_page}
  const TodosOverviewPage({super.key});

  /// The static route for TodosOverviewPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const TodosOverviewPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodosOverviewBloc(todosRepository: context.read<TodosRepository>())
            ..add(const TodosOverviewSubscriptionRequested()),
      child: const TodosOverviewView(),
    );
  }
}

/// {@template todos_overview_view}
/// Displays the Body of TodosOverviewView
/// {@endtemplate}
class TodosOverviewView extends StatelessWidget {
  /// {@macro todos_overview_view}
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              child: const Icon(Icons.add_rounded),
              onPressed: () => Navigator.push(context, EditTodoPage.route()),
            )
          : null,
      body: const TodosOverviewBody(),
    );
  }
}
