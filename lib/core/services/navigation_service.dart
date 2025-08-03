import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/core/constants/app_constants.dart';
import 'package:shartflix/core/theme/app_theme.dart';
import 'package:shartflix/core/utils/language_helper.dart';

import 'package:shartflix/core/utils/size_utils.dart';
import 'package:shartflix/shared/widgets/custom_button.dart';

import 'storage_service.dart';
import 'tab_controller.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/profile_photo_screen.dart';

class NavigationService {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', name: 'login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', name: 'register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/main', name: 'main', builder: (context, state) => const MainScreen()),
      GoRoute(path: '/profile-photo', name: 'profile-photo', builder: (context, state) => const ProfilePhotoScreen()),
    ],
    redirect: (context, state) async {
      final isLoggedIn = await StorageService.isLoggedIn();
      final isAuthRoute = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }

      if (isLoggedIn && isAuthRoute) {
        return '/main';
      }

      return null;
    },
  );

  static void goToLogin(BuildContext context) {
    context.go('/login');
  }

  static void goToRegister(BuildContext context) {
    context.go('/register');
  }

  static void goToMain(BuildContext context) {
    context.go('/main');
  }

  static void goBack(BuildContext context) {
    context.pop();
  }

  static void goToMovieDetail(BuildContext context, int movieId) {
    context.push('/movie/$movieId');
  }

  static void replaceToMain(BuildContext context) {
    context.go('/main');
  }

  static void clearAndGoToLogin(BuildContext context) {
    context.go('/login');
  }

  static void setTabIndex(int index) {
    AppTabController().setTabIndex(index);
  }

  static void goToHomeTab() {
    AppTabController().goToHome();
  }

  static void goToProfileTab() {
    AppTabController().goToProfile();
  }

  static void goToProfilePhoto(BuildContext context) {
    context.push('/profile-photo');
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late AppTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = AppTabController();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _tabController,
      builder: (context, child) {
        return Scaffold(
          body: IndexedStack(index: _tabController.currentIndex, children: const [HomeScreen(), ProfileScreen()]),
          bottomNavigationBar: SafeArea(
            child: Container(
              height: 71.h,
              color: AppTheme.backgroundColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    height: 41.h,
                    borderRadius: 18.h,
                    width: 140.h,
                    variant: _tabController.currentIndex == 0 ? CustomButtonVariant.filled : CustomButtonVariant.bottom,
                    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.h),
                    onPressed: () => AppTabController().setTabIndex(0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppConstants.homeIcon,
                          colorFilter: ColorFilter.mode(
                            _tabController.currentIndex == 0 ? Colors.white : AppTheme.textPrimaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          LanguageHelper.getNavigationString('home'),
                          style: AppTheme.bodyText6.copyWith(
                            color: _tabController.currentIndex == 0 ? Colors.white : AppTheme.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.h),
                  CustomButton(
                    height: 41.h,
                    borderRadius: 18.h,
                    width: 140.h,
                    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.h),
                    variant: _tabController.currentIndex == 1 ? CustomButtonVariant.filled : CustomButtonVariant.bottom,
                    onPressed: () => AppTabController().setTabIndex(1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppConstants.profileIcon,
                          colorFilter: ColorFilter.mode(
                            _tabController.currentIndex == 1 ? Colors.white : AppTheme.textPrimaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          LanguageHelper.getNavigationString('profile'),
                          style: AppTheme.bodyText6.copyWith(
                            color: _tabController.currentIndex == 1 ? Colors.white : AppTheme.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
