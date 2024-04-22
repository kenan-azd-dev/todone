import 'package:flutter/material.dart';

// Packages
import 'package:todos_repository/todos_repository.dart';

// Project
import 'package:todone/common/common.dart';
import 'package:todone/views/edit_todo/edit_todo.dart';
import 'package:todone/views/todo_details/todo_details.dart';

/// {@template todo_details_page}
/// A description for TodoDetailsPage
/// {@endtemplate}
class TodoDetailsPage extends StatelessWidget {
  /// {@macro todo_details_page}
  const TodoDetailsPage({
    super.key,
  });

  /// The static route for TodoDetailsPage
  static Route<dynamic> route(Todo todo) {
    return MaterialPageRoute<dynamic>(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (context) =>
            TodoDetailsBloc(todosRepository: context.read<TodosRepository>())
              ..add(
                TodoDetailsSubscriptionRequested(todo.id),
              ),
        child: const TodoDetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const TodoDetailsView();
  }
}

/// {@template todo_details_view}
/// Displays the Body of TodoDetailsView
/// {@endtemplate}
class TodoDetailsView extends StatelessWidget {
  /// {@macro todo_details_view}
  const TodoDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoDetailsBloc>().state.todo;
    return BlocBuilder<TodoDetailsBloc, TodoDetailsState>(
      builder: (context, state) {
        if (state.status == TodoDetailsStatus.loading ||
            state.status == TodoDetailsStatus.initial) {
          return const CircularProgressIndicator();
        }
        return Scaffold(
          appBar: AppBar(
            title: AppBarTitle(text: todo!.title),
            actions: [_EditTodoButton(todo: todo)],
          ),
          body: const Padding(
            padding: ViewsConstant.paddingAll,
            child: TodoDetailsBody(),
          ),
        );
      },
    );
  }
}

class _EditTodoButton extends StatelessWidget {
  const _EditTodoButton({required Todo todo}) : _todo = todo;

  final Todo _todo;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.push(
        context,
        EditTodoPage.route(initialTodo: _todo),
      ),
      icon: const Icon(Icons.edit_rounded),
    );
  }
}
