import 'package:flutter/material.dart';

// Project
import 'package:todone/l10n/l10n.dart';
import 'package:todone/views/settings/settings.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.settings_rounded),
                  title: Text(context.l10n.settingsLabel),
                  onTap: () => Navigator.push(
                    context,
                    SettingsPage.route(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
