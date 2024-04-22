import 'package:flutter/material.dart';

// Packages
import 'package:todos_api/todos_api.dart';

// Project
import 'package:todone/common/common.dart';
import 'package:todone/l10n/l10n.dart';
import 'package:todone/views/todo_details/todo_details.dart';

/// {@template todo_details_body}
/// Body of the TodoDetailsPage.
/// It consists of a table that shows the details
/// of the [Todo]. Pretty neat ngl ;)
///
/// Add what it does
/// {@endtemplate}
class TodoDetailsBody extends StatelessWidget {
  const TodoDetailsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final todo = context.watch<TodoDetailsBloc>().state.todo ?? Todo(title: '');
    final borderSide = BorderSide(
      width: 1,
      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
    );
    final dueTime = todo.dueTime;
    final dueDate = dueTime == null ? '' : Utils.dateFormat(dueTime);
    final dueTimeString = dueTime == null ? '' : Utils.jmzTime(dueTime);

    return Table(
      border: TableBorder(
        borderRadius: BorderRadius.circular(12.0),
        bottom: borderSide,
        left: borderSide,
        top: borderSide,
        right: borderSide,
        verticalInside: borderSide,
        horizontalInside: borderSide,
      ),
      children: [
        _buildTableRow(l10n.editTodoTitleLabel, todo.title),
        _buildTableRow(l10n.editTodoDescriptionLabel, todo.description ?? ''),
        _buildTableRow(l10n.editTodoDueDate, dueDate),
        _buildTableRow(l10n.editTodoDueTime, dueTimeString),
      ],
    );
  }

  TableRow _buildTableRow(String title, String content) {
    return TableRow(
      children: [
        _RowTitle(text: title),
        _RowContent(text: content),
      ],
    );
  }
}

class _RowContent extends StatelessWidget {
  const _RowContent({
    required String text,
  }) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(_text),
    );
  }
}

class _RowTitle extends StatelessWidget {
  const _RowTitle({
    required String text,
  }) : _text = text;
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        _text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
