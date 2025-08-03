import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shartflix/core/services/firebase_service.dart';
import '../../../core/services/api_service.dart';
import '../../../shared/models/user_model.dart';
import '../../../shared/models/movie_model.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class RefreshFavoriteMovies extends ProfileEvent {}

class RefreshProfileData extends ProfileEvent {}

class UpdateProfileImage extends ProfileEvent {
  final String imagePath;

  const UpdateProfileImage(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final List<MovieModel> favoriteMovies;

  const ProfileLoaded({required this.user, this.favoriteMovies = const []});

  ProfileLoaded copyWith({UserModel? user, List<MovieModel>? favoriteMovies}) {
    return ProfileLoaded(user: user ?? this.user, favoriteMovies: favoriteMovies ?? this.favoriteMovies);
  }

  @override
  List<Object?> get props => [user, favoriteMovies];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiService _apiService;
  bool _isRefreshingFavorites = false;

  ProfileBloc(this._apiService) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<RefreshFavoriteMovies>(_onRefreshFavoriteMovies);
    on<RefreshProfileData>(_onRefreshProfileData);
    on<UpdateProfileImage>(_onUpdateProfileImage);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = await _apiService.getProfile();
      emit(ProfileLoaded(user: user));
      final favoriteMovies = await _apiService.getFavoriteMovies();
      emit(ProfileLoaded(user: user, favoriteMovies: favoriteMovies));
    } catch (e) {
      emit(ProfileError(e.toString()));
      FirebaseService.logError(e, StackTrace.current, reason: 'Profil Yükleme hatası');
    }
  }

  Future<void> _onRefreshFavoriteMovies(RefreshFavoriteMovies event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded && !_isRefreshingFavorites) {
      final currentState = state as ProfileLoaded;
      _isRefreshingFavorites = true;
      try {
        final favoriteMovies = await _apiService.getFavoriteMovies();
        emit(currentState.copyWith(favoriteMovies: favoriteMovies));
      } catch (e) {
        emit(ProfileError(e.toString()));
        FirebaseService.logError(e, StackTrace.current, reason: 'Favorileri Güncelleme Hatası');
      } finally {
        Future.delayed(const Duration(milliseconds: 300), () {
          _isRefreshingFavorites = false;
        });
      }
    }
  }

  Future<void> _onRefreshProfileData(RefreshProfileData event, Emitter<ProfileState> emit) async {
    try {
      final user = await _apiService.getProfile();
      final favoriteMovies = await _apiService.getFavoriteMovies();
      emit(ProfileLoaded(user: user, favoriteMovies: favoriteMovies));
    } catch (e) {
      emit(ProfileError(e.toString()));
      FirebaseService.logError(e, StackTrace.current, reason: 'Profil Verilerini Yenileme hatası');
    }
  }

  Future<void> _onUpdateProfileImage(UpdateProfileImage event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      try {
        final imageUrl = await _apiService.uploadProfileImage(event.imagePath);
        final updatedUser = currentState.user.copyWith(photoUrl: imageUrl);
        emit(currentState.copyWith(user: updatedUser));
      } catch (e) {
        emit(ProfileError(e.toString()));
        FirebaseService.logError(e, StackTrace.current, reason: 'Profil Fotoğrafı Ekleme hatası');
      }
    }
  }
}
