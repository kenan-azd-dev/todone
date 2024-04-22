import 'package:flutter/material.dart';

// Packages
import 'package:intl/intl.dart';
import 'package:todos_api/todos_api.dart';

// Project
import 'package:todone/l10n/l10n.dart';
import 'package:todone/views/todo_details/todo_details.dart';
import 'package:todone/views/todos_overview/todos_overview.dart';
import 'package:todone/common/common.dart';

part 'todos_list_view.dart';
part 'todo_list_tile.dart';
part 'todos_filter_button.dart';
part 'weekly_calendar.dart';

/// {@template todos_body}
/// Body of the TodosPage.
///
/// Add what it does
/// {@endtemplate}
class TodosOverviewBody extends StatelessWidget {
  /// {@macro todos_body}
  const TodosOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodosOverviewBloc, TodosOverviewState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == TodosOverviewStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(l10n.todosOverviewErrorSnackbarText),
                  ),
                );
            }
          },
        ),
        BlocListener<TodosOverviewBloc, TodosOverviewState>(
          listenWhen: (previous, current) =>
              previous.lastDeletedTodo != current.lastDeletedTodo &&
              current.lastDeletedTodo != null,
          listener: (context, state) {
            final deletedTodo = state.lastDeletedTodo!;
            final messenger = ScaffoldMessenger.of(context);
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.todosOverviewTodoDeletedSnackbarText(
                      deletedTodo.title,
                    ),
                  ),
                  action: SnackBarAction(
                    label: l10n.todosOverviewUndoDeletionButtonText,
                    onPressed: () {
                      messenger.hideCurrentSnackBar();
                      context
                          .read<TodosOverviewBloc>()
                          .add(const TodosOverviewUndoDeletionRequested());
                    },
                  ),
                ),
              );
          },
        ),
      ],
      child: Column(
        children: [
          WeeklyCalendar(
            localeCode: l10n.localeName,
            todos: context.select<TodosOverviewBloc, List<Todo>>(
                (bloc) => bloc.state.todos),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.todosOverviewFilterTooltip),
            trailing: const TodosOverviewFilterButton(),
          ),
          const TodosListView()
        ],
      ),
    );
  }
}
