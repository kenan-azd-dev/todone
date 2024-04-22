part of 'theme_cubit.dart';

/// {@template theme_state}
/// The state of the [ThemeCubit] which includes the theme mode,
/// the color scheme, and the ThemeData for dark and light modes.
///
/// This state is equatable to allow for easy comparison.
/// {@endtemplate}
class ThemeState extends Equatable {
  /// The current theme mode of the app.
  final ThemeMode themeMode;

  /// The ThemeData for the dark theme.
  final ThemeData darkThemeData;

  /// The ThemeData for the light theme.
  final ThemeData lightThemeData;

  /// The current color scheme of the app.
  final Color? color;

  /// {@macro theme_state}
  const ThemeState({
    this.themeMode = ThemeMode.system,
    required this.darkThemeData,
    required this.lightThemeData,
    this.color,
  });

  /// Creates a copy of this state with the given fields replaced with
  /// the new values.
  ThemeState copyWith({
    ThemeMode? themeMode,
    ThemeData? darkThemeData,
    ThemeData? lightThemeData,
    Color? color,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      darkThemeData: darkThemeData ?? this.darkThemeData,
      lightThemeData: lightThemeData ?? this.lightThemeData,
      color: color,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        darkThemeData,
        lightThemeData,
        color,
      ];
}
