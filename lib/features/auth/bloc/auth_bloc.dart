import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/firebase_service.dart';
import '../../../shared/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterRequested(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService _apiService;

  AuthBloc(this._apiService) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _apiService.login(event.email, event.password);
      await StorageService.saveToken(response['token']);
      _apiService.setAuthToken(response['token']);
      final user = await _apiService.getProfile();
      await StorageService.saveUser(user);
      if (user.id != null) {
        await FirebaseService.logUserLogin(userId: user.id!, loginMethod: 'email');
      }
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      FirebaseService.logError(e, StackTrace.current, reason: 'Kullanıcı giriş hatası');
    }
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _apiService.register(event.name, event.email, event.password);
      await StorageService.saveToken(response['token']);
      _apiService.setAuthToken(response['token']);
      final user = await _apiService.getProfile();
      await StorageService.saveUser(user);
      if (user.id != null) {
        await FirebaseService.logUserLogin(userId: user.id!, loginMethod: 'register');
      }
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      FirebaseService.logError(e, StackTrace.current, reason: 'Kullanıcı kayıt hatası');
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await StorageService.removeToken();
    await StorageService.removeUser();
    _apiService.removeAuthToken();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    final token = await StorageService.getToken();
    final user = await StorageService.getUser();
    if (token != null && user != null) {
      _apiService.setAuthToken(token);
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
