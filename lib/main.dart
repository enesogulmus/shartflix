import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shartflix/core/utils/size_utils.dart';
import 'core/theme/app_theme.dart';
import 'core/services/navigation_service.dart';
import 'core/services/storage_service.dart';
import 'core/services/api_service.dart';
import 'core/services/localization_service.dart';
import 'core/services/firebase_service.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService.initialize();
  await StorageService.init();
  await LocalizationService().initialize();

  runApp(const ShartflixApp());
}

class ShartflixApp extends StatefulWidget {
  const ShartflixApp({super.key});

  @override
  State<ShartflixApp> createState() => _ShartflixAppState();
}

class _ShartflixAppState extends State<ShartflixApp> {
  Key _appKey = UniqueKey();

  void _restartApp() {
    setState(() {
      _appKey = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    LocalizationService().addListener(_restartApp);
  }

  @override
  void dispose() {
    LocalizationService().removeListener(_restartApp);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(ApiService())..add(CheckAuthStatus())),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(ApiService())),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            ApiService(),
            profileBloc: context.read<ProfileBloc>(),
          ),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) => LocalizationInheritedWidget(
          localizationService: LocalizationService(),
          child: MaterialApp.router(
            key: _appKey,
            title: 'Shartflix',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            routerConfig: NavigationService.router,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LocalizationService().supportedLocales,
            locale: LocalizationService().currentLocale,
          ),
        ),
      ),
    );
  }
}
