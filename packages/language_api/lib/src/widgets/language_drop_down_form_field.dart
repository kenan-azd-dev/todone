import 'package:flutter/material.dart';

// Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_api/language_api.dart';

/// {@template language_drop_down_form_field}
/// A reusable form field for selecting a language
/// using a dropdown menu.
/// {@endtemplate}
class LanguageDropDownFormField extends StatelessWidget {
  /// {@macro language_drop_down_form_field}
  const LanguageDropDownFormField({
    super.key,
    String hintText = 'Choose a language',
  }) : _text = hintText;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(18.0),
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      decoration: InputDecoration(
        hintText: _text,
        prefixIcon: const Icon(Icons.language_rounded),
      ),
      items: const [
        DropdownMenuItem(
          value: AppLanguage.english,
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: AppLanguage.arabic,
          child: Text('العربية'),
        ),
        DropdownMenuItem(
          value: AppLanguage.spanish,
          child: Text('Español'),
        ),
        DropdownMenuItem(
          value: AppLanguage.french,
          child: Text('Français'),
        ),
      ],
      onChanged: (language) => context.read<LanguageCubit>().setLanguage(
            language ?? AppLanguage.english,
          ),
    );
  }
}
