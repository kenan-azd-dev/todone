import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Packages
import 'package:todone/l10n/l10n.dart';

// Project
import 'package:todone/views/edit_todo/edit_todo.dart';
import 'package:todone/common/common.dart';
part 'todo_due_date_text_field.dart';
part 'todo_due_time_text_field.dart';
part 'todo_title_text_form_field.dart';
part 'todo_description_text_form_field.dart';

/// {@template edit_todo_body}
/// Body of the EditTodoPage.
///
/// It shows a form where the user could edit
/// the [Todo] title, description, due date
/// and due time.
/// {@endtemplate}
class EditTodoBody extends StatelessWidget {
  /// {@macro edit_todo_body}
  const EditTodoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocSelector<EditTodoBloc, EditTodoState, EditTodoStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, status) {
        return Column(
          children: [
            const TodoTitleTextFormField(),
            ViewsConstant.gap12,
            const TodoDescriptionTextFormField(),
            ViewsConstant.gap12,
            const Row(
              children: [
                TodoDueDateTextField(),
                ViewsConstant.gap12,
                TodoDueTimeTextField()
              ],
            ),
            const Spacer(),
            SizedBox(
              height: ViewsConstant.buttonHeight,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: status.isLoadingOrSuccess
                    ? null
                    : () => context.read<EditTodoBloc>().add(
                          const EditTodoSubmitted(),
                        ),
                child: Text(l10n.editTodoSaveButtonTooltip),
              ),
            )
          ],
        );
      },
    );
  }
}
