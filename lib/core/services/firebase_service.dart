import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'logger_service.dart';

class FirebaseService {
  static FirebaseAnalytics? _analytics;
  static FirebaseCrashlytics? _crashlytics;

  static FirebaseAnalytics get analytics => _analytics!;
  static FirebaseCrashlytics get crashlytics => _crashlytics!;

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      
      _analytics = FirebaseAnalytics.instance;
      _crashlytics = FirebaseCrashlytics.instance;

      FlutterError.onError = (FlutterErrorDetails details) {
        _crashlytics!.recordFlutterFatalError(details);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        _crashlytics!.recordError(error, stack, fatal: true);
        return true;
      };

      LoggerService.firebaseInfo('Firebase başarıyla başlatıldı');
    } catch (e) {
      LoggerService.firebaseError('Firebase başlatma hatası', e);
    }
  }

  static Future<void> logMovieFavorited({
    required String movieId,
    required String movieTitle,
    required bool isFavorited,
  }) async {
    try {
      await _analytics!.logEvent(
        name: 'movie_favorited',
        parameters: {
          'movie_id': movieId,
          'movie_title': movieTitle,
          'is_favorited': isFavorited ? 1 : 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
      LoggerService.analyticsInfo('Film favorileme olayı gönderildi: $movieTitle - $isFavorited');
    } catch (e) {
      LoggerService.analyticsError('Analytics olay gönderme hatası', e, StackTrace.current);
      _crashlytics!.recordError(e, StackTrace.current);
    }
  }

  static Future<void> logUserLogin({
    required String userId,
    required String loginMethod,
  }) async {
    try {
      await _analytics!.logEvent(
        name: 'user_login',
        parameters: {
          'user_id': userId,
          'login_method': loginMethod,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
      LoggerService.analyticsInfo('Kullanıcı giriş olayı gönderildi: $userId - $loginMethod');
    } catch (e) {
      LoggerService.analyticsError('Analytics olay gönderme hatası', e, StackTrace.current);
      _crashlytics!.recordError(e, StackTrace.current);
    }
  }

  static Future<void> logMovieViewed({
    required String movieId,
    required String movieTitle,
  }) async {
    try {
      await _analytics!.logEvent(
        name: 'movie_viewed',
        parameters: {
          'movie_id': movieId,
          'movie_title': movieTitle,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
      LoggerService.analyticsInfo('Film görüntüleme olayı gönderildi: $movieTitle');
    } catch (e) {
      LoggerService.analyticsError('Analytics olay gönderme hatası', e, StackTrace.current);
      _crashlytics!.recordError(e, StackTrace.current);
    }
  }

  static Future<void> logError(
    dynamic error,
    StackTrace? stackTrace, {
    String? reason,
  }) async {
    try {
      await _crashlytics!.recordError(
        error,
        stackTrace,
        reason: reason,
      );
      LoggerService.crashlyticsInfo('Hata kaydedildi: $error');
    } catch (e) {
      LoggerService.crashlyticsError('Hata kaydetme hatası', e);
    }
  }
} 