import 'package:dio/dio.dart';
import 'package:shartflix/core/services/storage_service.dart';
import 'package:shartflix/core/services/logger_service.dart';
import 'package:shartflix/core/utils/language_helper.dart';
import '../constants/app_constants.dart';
import '../../shared/models/user_model.dart';
import '../../shared/models/movie_model.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          LoggerService.info('🌐 API Request: ${options.method} ${options.path}');
          if (options.data != null) {
            LoggerService.debug('📤 Request Data: ${options.data}');
          }
          if (options.queryParameters.isNotEmpty) {
            LoggerService.debug('🔍 Query Parameters: ${options.queryParameters}');
          }
          
          return handler.next(options);
        },
        onResponse: (response, handler) {
          LoggerService.info('✅ API Response: ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}');
          LoggerService.debug('📥 Response Data: ${response.data}');
          
          return handler.next(response);
        },
        onError: (error, handler) {
          LoggerService.error('❌ API Error: ${error.response?.statusCode} ${error.requestOptions.method} ${error.requestOptions.path}', error);
          if (error.response?.data != null) {
            LoggerService.error('📥 Error Response: ${error.response?.data}', error);
          }
          
          return handler.next(error);
        },
      ),
    );
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/user/login', data: {'email': email, 'password': password});
      return response.data['data'];
    } on DioException catch (e) {
      LoggerService.error('Login error: ${e.message}', e);
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await _dio.post('/user/register', data: {'name': name, 'email': email, 'password': password});
      return response.data['data'];
    } on DioException catch (e) {
      LoggerService.error('Register error: ${e.message}', e);
      LoggerService.error('Register error response: ${e.response?.data}', e);
      throw _handleError(e);
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get('/user/profile');
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      LoggerService.error('Get profile error: ${e.message}', e);
      throw _handleError(e);
    }
  }

  Future<List<MovieModel>> getMovies({int page = 1}) async {
    try {
      final response = await _dio.get('/movie/list', queryParameters: {'page': page});
      final List<dynamic> moviesData = response.data['data']['movies'];
      return moviesData.map((json) => MovieModel.fromJson(json)).toList();
    } on DioException catch (e) {
      LoggerService.error('Get movies error: ${e.message}', e);
      throw _handleError(e);
    }
  }

  Future<List<MovieModel>> getFavoriteMovies() async {
    try {
      final response = await _dio.get('/movie/favorites');
      final List<dynamic> moviesData = response.data['data'];
      return moviesData.map((json) => MovieModel.fromJson(json)).toList();
    } on DioException catch (e) {
      LoggerService.error('Get favorite movies error: ${e.message}', e);
      throw _handleError(e);
    }
  }

  Future<void> toggleFavorite(String movieId) async {
    try {
      await _dio.post('/movie/favorite/$movieId');
    } on DioException catch (e) {
      LoggerService.error('Toggle favorite error: ${e.message}', e);
      throw _handleError(e);
    }
  }

  Future<String> uploadProfileImage(String imagePath) async {
    try {
      final formData = FormData.fromMap({'file': await MultipartFile.fromFile(imagePath)});
      final response = await _dio.post('/user/upload_photo', data: formData);
      return response.data['data']['photoUrl'];
    } on DioException catch (e) {
      LoggerService.error('Upload profile image error: ${e.message}', e);
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      await StorageService.removeToken();
      await StorageService.removeUser();
      removeAuthToken();
    } catch (e) {
      LoggerService.error('Logout error: $e', e);
      await StorageService.removeToken();
      await StorageService.removeUser();
      removeAuthToken();
    }
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return LanguageHelper.getErrorString('networkError');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['response']['message'] ?? LanguageHelper.getErrorString('genericError');

        switch (statusCode) {
          case 401:
            return LanguageHelper.getErrorString('invalidAuth');
          case 403:
            return LanguageHelper.getErrorString('deniedPermission');
          case 404:
            return LanguageHelper.getErrorString('notFound');
          case 413:
            return 'Dosya boyutu çok büyük. Lütfen daha küçük bir dosya seçin.';
          case 422:
            return message;
          case 500:
            return LanguageHelper.getErrorString('serverError');
          default:
            switch(message){
              case 'USER_EXISTS':
                return LanguageHelper.getErrorString('userExist');
            }
            return message;
        }
      case DioExceptionType.cancel:
        return LanguageHelper.getErrorString('cancelled');
      case DioExceptionType.connectionError:
        return LanguageHelper.getErrorString('networkError');
      default:
        return LanguageHelper.getErrorString('unknownError');
    }
  }
}
