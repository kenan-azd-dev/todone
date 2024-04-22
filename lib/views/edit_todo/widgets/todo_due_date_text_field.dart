part of 'edit_todo_body.dart';

/// {@template todo_due_date_text_form_field}
/// A simple form field that enables the user to edit
/// the due date of a [Todo]
/// {@endtemplate}
class TodoDueDateTextField extends StatelessWidget {
  /// {@macro todo_due_date_text_form_field}
  const TodoDueDateTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<EditTodoBloc>().state;
    late String hintText;
    if (state.dueDate != null) {
      hintText = Utils.dateFormat(state.dueDate!);
    } else if (state.initialTodo != null &&
        state.initialTodo!.dueDate != null) {
      hintText = Utils.dateFormat(state.initialTodo!.dueDate!);
    } else {
      hintText = l10n.editTodoDueTime;
    }
    return Expanded(
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: const Icon(Icons.calendar_month_rounded),
        ),
        onTap: () async {
          if (Platform.isAndroid) {
            await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2050),
              initialDate: DateTime.now(),
            ).then((dueDate) {
              if (dueDate == null) return;
              context.read<EditTodoBloc>().add(
                    EditTodoDueDateChanged(dueDate),
                  );
            });
          } else {
            _showCupertinoDatePicker(
              context,
              onDateTimeChanged: (dueDate) {
                context.read<EditTodoBloc>().add(
                      EditTodoDueDateChanged(dueDate),
                    );
              },
            );
          }
        },
      ),
    );
  }

  void _showCupertinoDatePicker(
    BuildContext context, {
    required ValueChanged<DateTime> onDateTimeChanged,
    DateTime? initialDateTime,
    int minimumYear = 2022,
    int maximumYear = 2030,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            onDateTimeChanged: onDateTimeChanged,
            initialDateTime: initialDateTime,
            minimumYear: minimumYear,
            maximumYear: maximumYear,
            dateOrder: DatePickerDateOrder.ymd,
          ),
        );
      },
    );
  }
}
