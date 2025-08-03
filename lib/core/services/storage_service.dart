import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../../shared/models/user_model.dart';
import 'logger_service.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static bool _initialized = false;

  static Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  static Future<void> saveToken(String token) async {
    await init();
    await _prefs.setString(AppConstants.tokenKey, token);
    LoggerService.info('Token saklandı');
  }

  static Future<String?> getToken() async {
    if (!_initialized) return null;
    return _prefs.getString(AppConstants.tokenKey);
  }

  static Future<void> removeToken() async {
    await init();
    await _prefs.remove(AppConstants.tokenKey);
    LoggerService.info('Token silindi');
  }

  static Future<void> saveUser(UserModel user) async {
    await init();
    await _prefs.setString(AppConstants.userKey, jsonEncode(user.toJson()));
    LoggerService.info('Kullanıcı verisi saklandı');
  }

  static Future<UserModel?> getUser() async {
    if (!_initialized) return null;
    final userJson = _prefs.getString(AppConstants.userKey);
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<void> removeUser() async {
    await init();
    await _prefs.remove(AppConstants.userKey);
    LoggerService.info('Kullanıcı verisi silindi');
  }

  static Future<void> clearAll() async {
    await init();
    await _prefs.clear();
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
} 