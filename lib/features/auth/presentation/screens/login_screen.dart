import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shartflix/core/constants/app_constants.dart';
import 'package:shartflix/core/services/navigation_service.dart';
import 'package:shartflix/core/utils/size_utils.dart';
import 'package:shartflix/shared/widgets/app_text_button.dart';
import 'package:shartflix/shared/widgets/app_text_field.dart';
import 'package:shartflix/shared/widgets/custom_button.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/language_helper.dart';
import '../../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginRequested(_emailController.text.trim(), _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            NavigationService.goToHomeTab();
            NavigationService.goToMain(context);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppTheme.errorColor));
          }
        },
        child: SafeArea(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 39.h, vertical: 39.h),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 180.h),
                    _buildWelcomeSection(),
                    SizedBox(height: 24.h),
                    _buildForm(),
                    SizedBox(height: 24.h),
                    _buildSocialButton(),
                    SizedBox(height: 24.h),
                    _buildSingUpSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: _emailController,
          labelText: LanguageHelper.getAuthString('email'),
          prefixIcon: SvgPicture.asset(AppConstants.emailIcon, fit: BoxFit.none),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LanguageHelper.getErrorString('emailRequired');
            }
            if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return LanguageHelper.getErrorString('invalidEmail');
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          focusNode: _emailFocusNode,
        ),
        SizedBox(height: 8.h),
        AppTextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          labelText: LanguageHelper.getAuthString('password'),
          prefixIcon: SvgPicture.asset(AppConstants.passwordIcon, fit: BoxFit.none),
          suffixIcon: InkWell(
            onTap: () => setState(() {
              _obscurePassword = !_obscurePassword;
            }),
            child: SvgPicture.asset(AppConstants.hideIcon, fit: BoxFit.none),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LanguageHelper.getErrorString('passwordRequired');
            }
            if (value.length < 6) {
              return LanguageHelper.getErrorString('passwordTooShort');
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          focusNode: _passwordFocusNode,
        ),
        SizedBox(height: 24.h),
        AppTextButton(onPressed: () {}, data: LanguageHelper.getAuthString('forgotPassword')),
        SizedBox(height: 16.h),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return CustomButton(
              text: LanguageHelper.getAuthString('login'),
              width: 324.h,
              height: 53.h,
              borderRadius: 18.h,
              onPressed: state is AuthLoading ? null : _login,
              state: state is AuthLoading ? true : false,
            );
          },
        ),
      ],
    );
  }

  Row _buildSocialButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          width: 60.h,
          height: 60.h,
          borderRadius: 18.h,
          onPressed: null,
          variant: CustomButtonVariant.outlined,
          isEnabled: false,
          padding: EdgeInsets.zero,
          child: SvgPicture.asset(AppConstants.googleIcon, fit: BoxFit.none),
        ),
        SizedBox(width: 8.h),
        CustomButton(
          width: 60.h,
          height: 60.h,
          borderRadius: 18.h,
          onPressed: null,
          variant: CustomButtonVariant.outlined,
          isEnabled: false,
          padding: EdgeInsets.zero,
          child: SvgPicture.asset(AppConstants.appleIcon, fit: BoxFit.none),
        ),
        SizedBox(width: 8.h),
        CustomButton(
          width: 60.h,
          height: 60.h,
          borderRadius: 18.h,
          onPressed: null,
          variant: CustomButtonVariant.outlined,
          isEnabled: false,
          padding: EdgeInsets.zero,
          child: SvgPicture.asset(AppConstants.facebookIcon, fit: BoxFit.none),
        ),
      ],
    );
  }

  Row _buildSingUpSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(LanguageHelper.getAuthString('noAccount'), style: AppTheme.bodyText4),
        TextButton(
          onPressed: () => NavigationService.goToRegister(context),
          child: Text(LanguageHelper.getAuthString('register'), style: AppTheme.bodyText5),
        ),
      ],
    );
  }

  SizedBox _buildWelcomeSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Text(
            LanguageHelper.getAuthString('welcomeMessageTitle'),
            style: AppTheme.headline2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(LanguageHelper.getAuthString('welcomeMessage'), style: AppTheme.headline3, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
