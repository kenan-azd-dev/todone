import 'package:flutter/material.dart';

// Packages
import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template language_drop_down_form_field}
/// A reusable form field for selecting `ThemeMode`
/// using a dropdown menu.
/// {@endtemplate}
class ThemeDropDown extends StatelessWidget {
  /// {@macro language_drop_down_form_field}
  const ThemeDropDown({super.key, 
    String hintText = 'Change theme',
  }) : _hintText = hintText;

  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(18.0),
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      decoration: InputDecoration(
        hintText: _hintText,
        prefixIcon: const Icon(Icons.language_rounded),
      ),
      items: const [
        DropdownMenuItem(
          value: ThemeMode.system,
          child: Text('System'),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text('Dark'),
        ),
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text('Light'),
        ),
      ],
      onChanged: (theme) => context.read<ThemeCubit>().setThemeMode(
            theme ?? ThemeMode.system,
          ),
    );
  }
}
