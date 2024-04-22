part of 'todos_overview_body.dart';

class TodosListView extends StatelessWidget {
  const TodosListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          if (state.status == TodosOverviewStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status != TodosOverviewStatus.success) {
            return const SizedBox();
          } else {
            return Center(
              child: Text(
                l10n.todosOverviewEmptyText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
        }
        return Expanded(
          child: ListView(
            children: [
              for (final todo in state.filteredTodos)
                TodoListTile(
                  todo: todo,
                  onDismissed: (direction) {
                    context.read<TodosOverviewBloc>().add(
                          TodosOverviewTodoDeleted(
                            todo,
                          ),
                        );
                  },
                  onToggleCompleted: (isCompleted) {
                    context.read<TodosOverviewBloc>().add(
                          TodosOverviewTodoCompletionToggled(
                            todo: todo,
                            isCompleted: isCompleted,
                          ),
                        );
                  },
                  onTap: () => Navigator.push(
                    context,
                    TodoDetailsPage.route(todo),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
