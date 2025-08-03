import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/firebase_service.dart';
import '../../../shared/models/movie_model.dart';
import '../../profile/bloc/profile_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovies extends HomeEvent {
  final bool refresh;

  const LoadMovies({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

class LoadMoreMovies extends HomeEvent {}

class ToggleFavorite extends HomeEvent {
  final String movieId;

  const ToggleFavorite(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class RefreshMovies extends HomeEvent {}

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieModel> movies;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const HomeLoaded({required this.movies, this.hasReachedMax = false, this.isLoadingMore = false});

  HomeLoaded copyWith({List<MovieModel>? movies, bool? hasReachedMax, bool? isLoadingMore}) {
    return HomeLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [movies, hasReachedMax, isLoadingMore];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService _apiService;
  final ProfileBloc? _profileBloc;
  int _currentPage = 1;
  bool _hasReachedMax = false;
  bool _isTogglingFavorite = false;

  HomeBloc(this._apiService, {ProfileBloc? profileBloc}) : _profileBloc = profileBloc, super(HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<ToggleFavorite>(_onToggleFavorite);
    on<RefreshMovies>(_onRefreshMovies);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    if (event.refresh) {
      _currentPage = 1;
      _hasReachedMax = false;
    }
    if (state is HomeLoaded && !event.refresh) {
      return;
    }
    emit(HomeLoading());
    try {
      final movies = await _apiService.getMovies(page: _currentPage);
      if (movies.isEmpty) {
        _hasReachedMax = true;
      }
      emit(HomeLoaded(movies: movies, hasReachedMax: _hasReachedMax));
    } catch (e) {
      emit(HomeError(e.toString()));
      FirebaseService.logError(e, StackTrace.current, reason: 'Film yükleme hatası');
    }
  }

  Future<void> _onLoadMoreMovies(LoadMoreMovies event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }
      emit(currentState.copyWith(isLoadingMore: true));
      try {
        _currentPage++;
        final newMovies = await _apiService.getMovies(page: _currentPage);
        if (newMovies.isEmpty) {
          _hasReachedMax = true;
        }
        final updatedMovies = [...currentState.movies, ...newMovies];
        emit(HomeLoaded(movies: updatedMovies, hasReachedMax: _hasReachedMax, isLoadingMore: false));
      } catch (e) {
        emit(HomeError(e.toString()));
        FirebaseService.logError(e, StackTrace.current, reason: 'Daha fazla film yükleme hatası');
      }
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded && !_isTogglingFavorite) {
      final currentState = state as HomeLoaded;
      _isTogglingFavorite = true;
      try {
        await _apiService.toggleFavorite(event.movieId);
        final updatedMovies = currentState.movies.map((movie) {
          if (movie.id == event.movieId) {
            return movie.copyWith(isFavorite: !movie.isFavorite);
          }
          return movie;
        }).toList();
        final toggledMovie = updatedMovies.firstWhere((movie) => movie.id == event.movieId);
        await FirebaseService.logMovieFavorited(
          movieId: toggledMovie.id,
          movieTitle: toggledMovie.title,
          isFavorited: toggledMovie.isFavorite,
        );
        emit(currentState.copyWith(movies: updatedMovies));
        if (_profileBloc != null) {
          _profileBloc.add(RefreshFavoriteMovies());
        }
      } catch (e) {
        emit(HomeError(e.toString()));
        FirebaseService.logError(e, StackTrace.current, reason: 'Film favorileme hatası');
      } finally {
        Future.delayed(const Duration(milliseconds: 500), () {
          _isTogglingFavorite = false;
        });
      }
    }
  }

  Future<void> _onRefreshMovies(RefreshMovies event, Emitter<HomeState> emit) async {
    add(const LoadMovies(refresh: true));
  }
}
