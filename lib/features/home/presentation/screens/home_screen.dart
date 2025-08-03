import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shartflix/core/constants/app_constants.dart';
import 'package:shartflix/core/utils/size_utils.dart';
import 'package:shartflix/shared/widgets/custom_button.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/language_helper.dart';
import '../../bloc/home_bloc.dart';
import 'package:shartflix/shared/models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  bool _isButtonPressed = false;
  int _lastViewedIndex = -1;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadMovies());
    _pageController.addListener(_onScroll);
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (((_pageController.page! % 4) == 0) && _pageController.page != 0) {
      context.read<HomeBloc>().add(LoadMoreMovies());
    }
  }

  void _onRefresh() async {
    context.read<HomeBloc>().add(RefreshMovies());
  }

  void _onPageChanged() {
    if (_pageController.page != null) {
      final currentIndex = _pageController.page!.round();
      final state = context.read<HomeBloc>().state;

      if (state is HomeLoaded && currentIndex < state.movies.length && currentIndex != _lastViewedIndex) {
        final movie = state.movies[currentIndex];
        _lastViewedIndex = currentIndex;

        FirebaseService.logMovieViewed(movieId: movie.id, movieTitle: movie.title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppTheme.errorColor));
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  _onRefresh();
                },
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        _buildMovieImage(movie),
                        _buildLinearGradient(),
                        _buildMovieInfo(movie),
                        _buildFavoriteButton(movie, context, state),
                      ],
                    );
                  },
                ),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: AppTheme.textSecondaryColor),
                    const SizedBox(height: 16),
                    Text(LanguageHelper.getProfileString('error')),
                    const SizedBox(height: 8),
                    Text(state.message, style: AppTheme.bodyText2, textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(const LoadMovies(refresh: true));
                      },
                      child: Text(LanguageHelper.getCommonString('retry')),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Positioned _buildFavoriteButton(MovieModel movie, BuildContext context, HomeLoaded state) {
    return Positioned(
      width: 49.h,
      height: 72.h,
      right: 16.5.h,
      bottom: 100.h,
      child: BackdropFilter(
        filter: ImageFilter.blur(),
        child: CustomButton(
          variant: CustomButtonVariant.outlined,
          borderColor: movie.isFavorite ? AppTheme.textPrimaryColor : AppTheme.textSecondaryColor,
          borderRadius: 20.h,
          backgroundColor: AppTheme.backgroundColor.withAlpha(20),
          padding: EdgeInsets.zero,
          onPressed: () {
            if (!_isButtonPressed) {
              _isButtonPressed = true;
              context.read<HomeBloc>().add(ToggleFavorite(movie.id));

              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  setState(() {
                    _isButtonPressed = false;
                  });
                }
              });
            }
          },
          child: SvgPicture.asset(
            AppConstants.favoriteIcon,
            fit: BoxFit.none,
            colorFilter: ColorFilter.mode(
              movie.isFavorite ? AppTheme.secondaryColor : AppTheme.textPrimaryColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildMovieInfo(MovieModel movie) {
    return Padding(
      padding: EdgeInsets.only(left: 33.h, right: 16.5.h, bottom: 8.h),
      child: Column(
        children: [
          Spacer(),
          Row(
            children: [
              Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.textPrimaryColor, width: 1.5.h),
                  borderRadius: BorderRadius.circular(21.h),
                  color: AppTheme.secondaryColor,
                ),
                child: SvgPicture.asset(AppConstants.logoIcon, fit: BoxFit.none),
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: AppTheme.headline2),
                    RichText(
                      maxLines: 2,
                      text: TextSpan(
                        text: movie.description.substring(0, 70),
                        style: AppTheme.headline3.copyWith(color: AppTheme.textPrimaryColor.withAlpha(75)),
                        children: [
                          TextSpan(
                            text: LanguageHelper.getCommonString('more'),
                            style: AppTheme.headline3.copyWith(
                              color: AppTheme.textPrimaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildLinearGradient() {
    return Column(
      children: [
        Spacer(),
        Container(
          height: 70.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppTheme.backgroundColor, AppTheme.backgroundColor.withAlpha(0)],
            ),
          ),
        ),
      ],
    );
  }

  CachedNetworkImage _buildMovieImage(MovieModel movie) => CachedNetworkImage(
    imageUrl: movie.posterPath.contains('https')
        ? movie.posterPath
        : movie.posterPath.contains('http')
        ? movie.posterPath.replaceAll('http', 'https')
        : 'https://${movie.posterPath}',
    fit: BoxFit.cover,
  );
}
