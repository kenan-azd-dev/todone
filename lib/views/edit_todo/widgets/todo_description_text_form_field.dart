part of 'edit_todo_body.dart';

/// {@template todo_description_text_form_field}
/// A simple form field that enables the user to edit
/// the description of a [Todo]
/// {@endtemplate}
class TodoDescriptionTextFormField extends StatelessWidget {
  /// {@macro todo_description_text_form_field}
  const TodoDescriptionTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTodoBloc>().state;
    final l10n = context.l10n;
    final label = l10n.editTodoDescriptionLabel;
    final initialText =
        state.description.isNotEmpty ? state.initialTodo?.description : null;

    return TextFormField(
      initialValue: initialText,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text(label),
      ),
      maxLines: 3,
      maxLength: 300,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        context.read<EditTodoBloc>().add(EditTodoDescriptionChanged(value));
      },
    );
  }
}
