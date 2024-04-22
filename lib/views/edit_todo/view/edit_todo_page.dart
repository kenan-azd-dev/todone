import 'package:flutter/material.dart';

// Packages
import 'package:todos_repository/todos_repository.dart';

// Project
import 'package:todone/common/common.dart';
import 'package:todone/l10n/l10n.dart';
import 'package:todone/views/edit_todo/edit_todo.dart';

/// {@template edit_todo_page}
/// This is where the users could add/edit their [Todo]s.
/// Pretty reusable ngl ;)
/// {@endtemplate}
class EditTodoPage extends StatelessWidget {
  /// {@macro edit_todo_page}
  const EditTodoPage({super.key});

  /// The static route for EditTodoPage
  static Route<void> route({Todo? initialTodo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditTodoBloc(
          todosRepository: context.read<TodosRepository>(),
          initialTodo: initialTodo,
        ),
        child: const EditTodoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTodoBloc, EditTodoState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditTodoStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditTodoView(),
    );
  }
}

/// {@template edit_todo_view}
/// Displays the Body of [EditTodoView]
/// {@endtemplate}
class EditTodoView extends StatelessWidget {
  /// {@macro edit_todo_view}
  const EditTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isNewTodo = context.select(
      (EditTodoBloc bloc) => bloc.state.isNewTodo,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: AppBarTitle(
          text: isNewTodo
              ? l10n.editTodoAddAppBarTitle
              : l10n.editTodoEditAppBarTitle,
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: ViewsConstant.paddingAll,
          child: EditTodoBody(),
        ),
      ),
    );
  }
}
