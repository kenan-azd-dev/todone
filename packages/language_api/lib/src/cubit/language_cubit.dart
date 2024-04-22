import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppLanguage { english, arabic, spanish, french }

extension AppLanguageExtension on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.english:
        return 'en';
      case AppLanguage.arabic:
        return 'ar';
      case AppLanguage.spanish:
        return 'es';
      case AppLanguage.french:
        return 'fr';
      default:
        return 'en';
    }
  }

  Locale get locale {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.arabic:
        return const Locale('ar');
      case AppLanguage.spanish:
        return const Locale('es');
      case AppLanguage.french:
        return const Locale('fr');
      default:
        return const Locale('en');
    }
  }
}

class LanguageCubit extends Cubit<AppLanguage> {
  LanguageCubit() : super(AppLanguage.english) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    emit(AppLanguage.values.firstWhere(
      (language) => language.code == languageCode,
      orElse: () => AppLanguage.english,
    ));
  }

  Future<void> setLanguage(AppLanguage language) async {
    // Save the language selection to shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', language.code);
    emit(language);
  }
}
