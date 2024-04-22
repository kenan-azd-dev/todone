part of 'edit_todo_body.dart';

/// {@template todo_due_time_text_form_field}
/// A simple form field that enables the user to edit
/// the due time of a [Todo]
/// {@endtemplate}
class TodoDueTimeTextField extends StatelessWidget {
  /// {@macro todo_due_time_text_form_field}
  const TodoDueTimeTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<EditTodoBloc>().state;
    late String hintText;
    if (state.dueTime != null) {
      hintText = Utils.jmzTime(state.dueTime!);
    } else if (state.initialTodo != null &&
        state.initialTodo!.dueTime != null) {
      hintText = Utils.jmzTime(state.initialTodo!.dueTime!);
    } else {
      hintText = l10n.editTodoDueTime;
    }
    return Expanded(
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: const Icon(Icons.access_time_filled_rounded),
        ),
        onTap: () async {
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((dueTime) {
            if (dueTime == null) return;
            context.read<EditTodoBloc>().add(
                  EditTodoDueTimeChanged(
                    DateTime.now().applied(dueTime),
                  ),
                );
          });
        },
      ),
    );
  }
}
