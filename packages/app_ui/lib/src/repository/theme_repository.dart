import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  ThemeRepository({required SharedPreferences plugin}) : _plugin = plugin;

  final SharedPreferences _plugin;

  @visibleForTesting
  final kThemeKey = '__theme_key__';

  @visibleForTesting
  final kColorKey = '__color_key__';

  /// Saves the selected color to SharedPreferences
  void saveColor(Color? color) => color == null
      ? _plugin.remove(kColorKey)
      : _plugin.setInt(kColorKey, color.value);

  /// Loads the selected color from SharedPreferences
  Color? loadColor() => _plugin.getInt(kColorKey) == null
      ? null
      : Color(_plugin.getInt(kColorKey)!);

  void saveTheme(String value) => _plugin.setString(kThemeKey, value);

  ThemeMode loadTheme() => _plugin.getString(kThemeKey) == 'dark'
      ? ThemeMode.dark
      : _plugin.getString(kThemeKey) == 'light'
          ? ThemeMode.light
          : ThemeMode.system;
}
