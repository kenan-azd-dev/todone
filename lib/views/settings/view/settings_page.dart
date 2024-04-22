import 'package:flutter/material.dart';
import 'package:todone/common/common.dart';
import 'package:todone/l10n/l10n.dart';
import 'package:todone/views/settings/cubit/cubit.dart';
import 'package:todone/views/settings/widgets/settings_body.dart';

/// {@template settings_page}
/// A description for SettingsPage
/// {@endtemplate}
class SettingsPage extends StatelessWidget {
  /// {@macro settings_page}
  const SettingsPage({super.key});

  /// The static route for SettingsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: const SettingsView(),
    );
  }
}

/// {@template settings_view}
/// Displays the Body of SettingsView
/// {@endtemplate}
class SettingsView extends StatelessWidget {
  /// {@macro settings_view}
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsLabel),
      ),
      body: const SafeArea(
        child: Padding(
          padding: ViewsConstant.paddingAll,
          child: SettingsBody(),
        ),
      ),
    );
  }
}
