part of 'todos_overview_body.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    required Todo todo,
    required void Function(DismissDirection)? onDismissed,
    required void Function()? onTap,
    required ValueChanged<bool>? onToggleCompleted
  })  : _todo = todo,
        _onDismissed = onDismissed,
        _onTap = onTap,
        _onToggleCompleted = onToggleCompleted;

  final Todo _todo;
  final void Function(DismissDirection)? _onDismissed;
  final void Function()? _onTap;
  final ValueChanged<bool>? _onToggleCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Dismissible(
        key: Key(_todo.id),
        onDismissed: _onDismissed,
        background: Container(
          padding: const EdgeInsets.only(right: 12.0),
          alignment: Alignment.centerRight,
          color: Theme.of(context).colorScheme.error,
          child: Icon(
            Icons.delete_rounded,
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
        child: ListTile(
          onTap: _onTap,
          title: Text(
            _todo.title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(_todo.dueDate != null
              ? DateFormat.yMMMEd('en').format(
                  _todo.dueDate!,
                )
              : ''),
          trailing: Checkbox(
            value: _todo.isCompleted,
            onChanged: _onToggleCompleted == null
              ? null
              : (value) => _onToggleCompleted(value!),
          ),
        ),
      ),
    );
  }
}
