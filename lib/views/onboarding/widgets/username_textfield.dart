import 'package:flutter/material.dart';
import 'package:todone/l10n/l10n.dart';

/// {@template username_text_field}
/// A text field that enables the user to
/// enter their name or nickname.
///
/// It cannot be empty. and the name should at least be 3
/// characters long and no greater than 30 characters long.
/// {@endtemplate}
class UsernameTextField extends StatelessWidget {
  /// {@macro template}
  const UsernameTextField({
    super.key,
    String? initialValue,
    void Function(String value)? onChanged,
  }) : _initialValue = initialValue,
       _onChanged = onChanged;

  final String? _initialValue;
  final void Function(String value)? _onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.name,
      maxLength: 30,
      decoration: InputDecoration(label: Text(l10n.settingsEditUsernameLabel)),
      textCapitalization: TextCapitalization.words,
      initialValue: _initialValue,
      onChanged: _onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.settingsEditUsernameEmptyError;
        }
        if (value.length < 3) {
          return l10n
              .settingsEditUsernameShortError; // Must at least be 3 characters long.
        }
        return null;
      },
    );
  }
}
