import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shartflix/core/constants/app_constants.dart';
import 'package:shartflix/core/utils/size_utils.dart';
import 'package:shartflix/shared/widgets/custom_button.dart';
import 'package:shartflix/shared/widgets/limited_offer_bottom_sheet.dart';
import 'package:shartflix/shared/widgets/language_selector.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/language_helper.dart';
import '../../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      floatingActionButton: Container(
        height: 40.h,
        width: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.h), color: AppTheme.secondaryColor),
        child: PopupMenuButton<String>(
          icon: const Icon(Icons.settings, color: AppTheme.textPrimaryColor, size: 32),
          padding: EdgeInsetsGeometry.zero,
          itemBuilder: (BuildContext context) {
            return [PopupMenuItem<String>(child: LanguageSelector()), PopupMenuItem<String>(child: _buildExitToApp())];
          },
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppTheme.errorColor));
          }
        },
        child: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileLoaded) {
                return Column(
                  children: [
                    _buildHeader(context),
                    SizedBox(height: 37.h),
                    _buildAccountInfo(state),
                    SizedBox(height: 29.h),
                    _buildFavoriteMovie(state),
                  ],
                );
              }
              if (state is ProfileError) {
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
                          context.read<ProfileBloc>().add(LoadProfile());
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
      ),
    );
  }

  IconButton _buildExitToApp() {
    return IconButton(onPressed: _showLogoutDialog, icon: Icon(Icons.exit_to_app));
  }

  Widget _buildFavoriteMovie(ProfileLoaded state) {
    if (state.favoriteMovies.isEmpty) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: AppTheme.textSecondaryColor),
            const SizedBox(height: 16),
            Text(LanguageHelper.getProfileString('noFavorites'), style: AppTheme.bodyText1),
            const SizedBox(height: 8),
            Text(
              LanguageHelper.getProfileString('favoritesDescription'),
              style: AppTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return Expanded(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(LanguageHelper.getProfileString('favoriteMovies'), style: AppTheme.bodyText7),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.h,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.5.h,
                ),
                itemCount: state.favoriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.favoriteMovies[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8.h)),
                        child: AspectRatio(
                          aspectRatio: 0.71.h,
                          child: CachedNetworkImage(
                            imageUrl: movie.posterPath.contains('https')
                                ? movie.posterPath
                                : movie.posterPath.contains('http')
                                ? movie.posterPath.replaceAll('http', 'https')
                                : 'https://${movie.posterPath}',
                            errorWidget: (context, url, error) => Placeholder(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(movie.title, style: AppTheme.bodyText6),
                      Text(
                        movie.director == 'N/A' ? movie.writer : movie.director,
                        maxLines: 1,
                        style: AppTheme.bodyText5.copyWith(
                          height: 1.5.h,
                          color: AppTheme.textPrimaryColor.withAlpha(50),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildAccountInfo(ProfileLoaded state) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 35.h, right: 26.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(31.h),
            child: Container(
              height: 62.h,
              width: 62.h,
              decoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(31.h)),
              child: CachedNetworkImage(
                imageUrl: state.user.photoUrl ?? '',
                errorWidget: (context, url, error) =>
                    Icon(Icons.account_circle_rounded, size: 61, color: AppTheme.secondaryColor),
              ),
            ),
          ),
          SizedBox(width: 9.h),
          FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.user.name ?? LanguageHelper.getProfileString('unknown'), style: AppTheme.bodyText1),
                Text('ID: ${state.user.id?.substring(0, 6)}', style: AppTheme.bodyText4),
              ],
            ),
          ),
          Spacer(),
          CustomButton(
            variant: CustomButtonVariant.filled,
            borderRadius: 8.h,
            height: 38.h,
            width: 125.h,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 19.h),
            child: Text(LanguageHelper.getProfileString('addPhoto'), style: AppTheme.bodyText7),
            onPressed: () => NavigationService.goToProfilePhoto(context),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.h)),
          title: Text(LanguageHelper.getProfileString('logout'), style: AppTheme.bodyText1),
          content: Text(LanguageHelper.getProfileString('logoutConfirm'), style: AppTheme.bodyText2),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LanguageHelper.getCommonString('cancel'), style: AppTheme.bodyText2),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
              child: Text(
                LanguageHelper.getProfileString('logout'),
                style: AppTheme.bodyText2.copyWith(color: AppTheme.errorColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performLogout() async {
    try {
      final apiService = ApiService();
      await apiService.logout();

      if (mounted) {
        NavigationService.clearAndGoToLogin(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LanguageHelper.getProfileString('logoutError')), backgroundColor: AppTheme.errorColor),
        );
      }
    }
  }

  void _showLimitedOfferBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LimitedOfferBottomSheet(),
    );
  }

  Padding _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 25.h),
      child: Row(
        children: [
          CustomButton(
            variant: CustomButtonVariant.outlined,
            height: 44.h,
            width: 44.h,
            onPressed: () => NavigationService.goToHomeTab(),
            borderRadius: 22.h,
            backgroundColor: AppTheme.textPrimaryColor.withAlpha(20),
            borderColor: AppTheme.textSecondaryColor,
            padding: EdgeInsets.zero,
            child: SvgPicture.asset(AppConstants.backIcon, fit: BoxFit.none),
          ),
          Spacer(flex: 8),
          Text(LanguageHelper.getProfileString('profileDetail'), style: AppTheme.bodyText1),
          Spacer(flex: 2),
          CustomButton(
            variant: CustomButtonVariant.filled,
            height: 33.h,
            onPressed: () => _showLimitedOfferBottomSheet(),
            borderRadius: 53.h,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 9.h),
            child: FittedBox(
              child: Row(
                children: [
                  SvgPicture.asset(AppConstants.limitedOfferIcon, fit: BoxFit.none),
                  SizedBox(width: 4.h),
                  Text(LanguageHelper.getProfileString('limitedOffer'), style: AppTheme.bodyText6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
