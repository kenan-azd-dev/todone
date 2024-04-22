import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:language_api/language_api.dart';
import 'package:todone/common/common.dart';
import 'package:todone/views/onboarding/onboarding.dart';

/// {@template settings_body}
/// Body of the SettingsPage.
///
/// Add what it does
/// {@endtemplate}
class SettingsBody extends StatelessWidget {
  /// {@macro settings_body}
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ThemeDropDown(),
        ViewsConstant.gap18,
        const LanguageDropDownFormField(),
        ViewsConstant.gap18,
        SizedBox(
          width: double.maxFinite,
          height: ViewsConstant.buttonHeight,
          child: OutlinedButton(
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll(
                EdgeInsets.all(12),
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            onPressed: () => showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Change name'),
                  content: UsernameTextField(),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                    OutlinedButton(onPressed: () {}, child: Text('Save')),
                  ],
                );
              },
            ),
            child: Row(
              children: [
                const Icon(Icons.person_rounded),
                ViewsConstant.gap12,
                Text(
                  'Change username',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
