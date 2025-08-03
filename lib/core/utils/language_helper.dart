import '../constants/strings.dart';
import '../services/localization_service.dart';

class LanguageHelper {
  static String getString(String category, String key) {
    final currentLanguage = LocalizationService().currentLocale.languageCode;
    return Strings.get(category, key, currentLanguage);
  }

  static String getAuthString(String key) {
    return getString('auth', key);
  }

  static String getErrorString(String key) {
    return getString('errors', key);
  }

  static String getNavigationString(String key) {
    return getString('navigation', key);
  }

  static String getLanguageString(String key) {
    return getString('language', key);
  }

  static String getCommonString(String key) {
    return getString('common', key);
  }

  static String getProfileString(String key) {
    return getString('profile', key);
  }

  static String getPhotoString(String key) {
    return getString('photo', key);
  }

  static String getOfferString(String key) {
    return getString('offer', key);
  }

  static String getCurrentLanguage() {
    return LocalizationService().currentLocale.languageCode;
  }

  static bool isTurkish() {
    return getCurrentLanguage() == 'tr';
  }

  static bool isEnglish() {
    return getCurrentLanguage() == 'en';
  }

  static String getLanguageName(String languageCode) {
    return LocalizationService().getLanguageName(languageCode);
  }

  static String getLanguageFlag(String languageCode) {
    return LocalizationService().getLanguageFlag(languageCode);
  }

  static List<Map<String, String>> getSupportedLanguages() {
    return [
      {'code': 'tr', 'name': getLanguageName('tr'), 'flag': getLanguageFlag('tr')},
      {'code': 'en', 'name': getLanguageName('en'), 'flag': getLanguageFlag('en')},
    ];
  }
}
