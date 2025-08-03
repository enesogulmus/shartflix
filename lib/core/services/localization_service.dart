import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shartflix/core/utils/language_helper.dart';
import '../constants/app_constants.dart';

class LocalizationService extends ChangeNotifier {
  static final LocalizationService _instance = LocalizationService._internal();

  factory LocalizationService() => _instance;

  LocalizationService._internal();

  static const Locale _defaultLocale = Locale('tr', 'TR');
  static const List<Locale> _supportedLocales = [Locale('tr'), Locale('en')];

  Locale _currentLocale = _defaultLocale;

  Locale get currentLocale => _currentLocale;

  List<Locale> get supportedLocales => _supportedLocales;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(AppConstants.languageKey) ?? 'tr';
    _currentLocale = Locale(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    if (!_supportedLocales.contains(locale)) return;

    _currentLocale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.languageKey, locale.languageCode);

    notifyListeners();
  }

  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'tr':
        return LanguageHelper.getLanguageString('tr');
      case 'en':
        return LanguageHelper.getLanguageString('en');
      default:
        return LanguageHelper.getLanguageString('tr');
    }
  }

  String getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'tr':
        return '🇹🇷';
      case 'en':
        return '🇺🇸';
      default:
        return '🇹🇷';
    }
  }
}

class LocalizationInheritedWidget extends InheritedWidget {
  final LocalizationService localizationService;

  const LocalizationInheritedWidget({super.key, required this.localizationService, required super.child});

  static LocalizationInheritedWidget of(BuildContext context) {
    final LocalizationInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<LocalizationInheritedWidget>();
    assert(result != null, 'No LocalizationInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LocalizationInheritedWidget oldWidget) {
    return localizationService != oldWidget.localizationService;
  }
}
