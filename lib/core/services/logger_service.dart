import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static Logger get logger => _logger;

  static void info(String message) {
    _logger.i(message);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  static void trace(String message) {
    _logger.t(message);
  }

  static void firebaseInfo(String message) {
    _logger.i('🔥 Firebase: $message');
  }

  static void firebaseError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e('🔥 Firebase Error: $message', error: error, stackTrace: stackTrace);
  }

  static void analyticsInfo(String message) {
    _logger.i('📊 Analytics: $message');
  }

  static void analyticsError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e('📊 Analytics Error: $message', error: error, stackTrace: stackTrace);
  }

  static void crashlyticsInfo(String message) {
    _logger.i('🐛 Crashlytics: $message');
  }

  static void crashlyticsError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e('🐛 Crashlytics Error: $message', error: error, stackTrace: stackTrace);
  }
} 