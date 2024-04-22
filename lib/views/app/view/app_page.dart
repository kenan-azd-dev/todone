import 'package:flutter/material.dart';

// Local packages
import 'package:app_ui/app_ui.dart';
import 'package:language_api/language_api.dart';
import 'package:todone/l10n/l10n.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:username/username.dart';

// 3rd Party Packages
import 'package:shared_preferences/shared_preferences.dart';

// Project
import 'package:todone/views/onboarding/cubit/cubit.dart';
import 'package:todone/views/onboarding/view/onboarding_page.dart';

/// {@template app_page}
/// This the entry point of the widgets.
/// {@endtemplate}
class TodoneApp extends StatelessWidget {
  /// {@macro app_page}
  const TodoneApp({
    super.key,
    required SharedPreferences plugin,
    required TodosApi todosApi,
  })  : _plugin = plugin,
        _todosApi = todosApi;

  final SharedPreferences _plugin;
  final TodosApi _todosApi;

  @override
  Widget build(BuildContext context) {
    return _RepoProvider(
      plugin: _plugin,
      todosApi: _todosApi,
    );
  }
}
/// {@template repository_provider}
/// The purpose of this widget is to provide the repositories
/// to the descendant widgets.
/// {@endtemplate}
class _RepoProvider extends StatelessWidget {
  /// {@macro repository_provider}
  const _RepoProvider({
    required SharedPreferences plugin,
    required TodosApi todosApi,
  })  : _plugin = plugin,
        _todosApi = todosApi;

  final SharedPreferences _plugin;
  final TodosApi _todosApi;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UsernameRepository(plugin: _plugin),
        ),
        RepositoryProvider(
          create: (context) => ThemeRepository(plugin: _plugin),
        ),
        RepositoryProvider(
          create: (context) => TodosRepository(todosApi: _todosApi),
        )
      ],
      child: const _BusinessLogicProvider(),
    );
  }
}

/// {@template business_logic_provider}
/// The purpose of this widget is to provide BLoCs that
/// are used in across all widgets like theme, language,
/// and username.
/// {@endtemplate}
class _BusinessLogicProvider extends StatelessWidget {
  /// {@macro business_logic_provider}
  const _BusinessLogicProvider();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) =>
              UsernameCubit(context.read<UsernameRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              ThemeCubit(context.read<ThemeRepository>())..loadTheme(),
        )
      ],
      child: const AppView(),
    );
  }
}

/// {@template app_view}
/// Displays the Body of AppView
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeCubit>().state.themeMode,
      theme: context.watch<ThemeCubit>().state.lightThemeData,
      darkTheme: context.watch<ThemeCubit>().state.darkThemeData,
      locale: context.watch<LanguageCubit>().state.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const OnboardingPage(),
    );
  }
}
