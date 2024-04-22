part of 'edit_todo_body.dart';

/// {@template todo_title_text_form_field}
/// A simple form field that enables the user to edit
/// the title of a [Todo]
/// {@endtemplate}
class TodoTitleTextFormField extends StatelessWidget {
  /// {@macro todo_title_text_form_field}
  const TodoTitleTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTodoBloc>().state;
    final l10n = context.l10n;
    final label = l10n.editTodoTitleLabel;
    final initialText =
        state.title.isNotEmpty ? state.initialTodo?.title : null;

    return TextFormField(
      initialValue: initialText,
      enabled: !state.status.isLoadingOrSuccess,
      decoration: InputDecoration(
        label: Text(label),
      ),
      maxLength: 50,
      onChanged: (value) {
        context.read<EditTodoBloc>().add(EditTodoTitleChanged(value));
      },
    );
  }
}
