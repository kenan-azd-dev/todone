import 'package:app_ui/app_ui.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';
/// {@template theme_cubit}
/// A Cubit that manages the theme state of the app.
///
/// It interacts with [ThemeRepository] to persist theme preferences and
/// provides methods to update and load theme settings.
/// {@endtemplate}
class ThemeCubit extends Cubit<ThemeState> {
  /// {@macro theme_cubit}
  ThemeCubit(ThemeRepository themeRepository)
      : _themeRepository = themeRepository,
        super(ThemeState(
          darkThemeData: CoreTheme.standardDark,
          lightThemeData: CoreTheme.standard,
        ));

  final ThemeRepository _themeRepository;

  /// Sets the color scheme of the app and emits a new [ThemeState].
  ///
  /// The color is saved in the repository and both dark and light theme data
  /// are updated to reflect the new color scheme.
  void setColorScheme(Color color) {
    _themeRepository.saveColor(color);
    emit(
      state.copyWith(
        color: color,
        darkThemeData: CoreTheme.theme(Brightness.dark, color),
        lightThemeData: CoreTheme.theme(Brightness.light, color),
      ),
    );
  }

  /// Sets the theme mode of the app and emits a new [ThemeState].
  ///
  /// The theme mode is saved in the repository.
  void setThemeMode(ThemeMode themeMode) {
    _themeRepository.saveTheme(themeMode.name);
    emit(
      state.copyWith(
        themeMode: themeMode,
      ),
    );
  }

  /// Resets the theme to default and emits a new [ThemeState].
  ///
  /// The color is removed from the repository and the theme data is reset
  /// to the standard dark and light themes.
  void setDefaultTheme() {
    _themeRepository.saveColor(null);
    emit(
      state.copyWith(
        darkThemeData: CoreTheme.standardDark,
        lightThemeData: CoreTheme.standard,
      ),
    );
  }

  /// Loads the theme from the repository and emits a new [ThemeState].
  ///
  /// If a color is saved, it is used to update the theme data. Otherwise,
  /// the standard themes are used.
  void loadTheme() {
    final color = _themeRepository.loadColor();
    final themeMode = _themeRepository.loadTheme();
    if (color != null) {
      emit(
        state.copyWith(
          themeMode: themeMode,
          color: color,
          darkThemeData: CoreTheme.theme(Brightness.dark, color),
          lightThemeData: CoreTheme.theme(Brightness.light, color),
        ),
      );
    } else {
      emit(
        state.copyWith(
          themeMode: themeMode,
          darkThemeData: CoreTheme.standardDark,
          lightThemeData: CoreTheme.standard,
        ),
      );
    }
  }
}
