import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shartflix/core/constants/app_constants.dart';
import 'package:shartflix/core/services/navigation_service.dart';
import 'package:shartflix/core/utils/language_helper.dart';
import 'package:shartflix/core/utils/size_utils.dart';
import 'package:shartflix/shared/widgets/app_text_field.dart';
import 'package:shartflix/shared/widgets/custom_button.dart';
import '../../../../core/theme/app_theme.dart';
import '../../bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        RegisterRequested(_nameController.text.trim(), _emailController.text.trim(), _passwordController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            NavigationService.goToProfilePhoto(context);
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 50.h),
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

  SizedBox _buildWelcomeSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Text(
            LanguageHelper.getAuthString('registerMessageTitle'),
            style: AppTheme.headline2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(LanguageHelper.getAuthString('welcomeMessage'), style: AppTheme.headline3, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Column _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: _nameController,
          keyboardType: TextInputType.name,
          labelText: LanguageHelper.getAuthString('name'),
          prefixIcon: SvgPicture.asset(AppConstants.emailIcon, fit: BoxFit.none),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LanguageHelper.getAuthString('requiredName');
            }
            if (value.length < 2) {
              return LanguageHelper.getAuthString('nameAtLeast');
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          focusNode: _nameFocusNode,
        ),
        SizedBox(height: 8.h),
        AppTextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LanguageHelper.getErrorString('emailRequired');
            }
            if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return LanguageHelper.getErrorString('invalidEmail');
            }
            return null;
          },
          labelText: LanguageHelper.getAuthString('email'),
          prefixIcon: SvgPicture.asset(AppConstants.emailIcon, fit: BoxFit.none),

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
          textInputAction: TextInputAction.next,
          focusNode: _passwordFocusNode,
        ),
        SizedBox(height: 8.h),
        AppTextField(
          controller: _confirmPasswordController,
          labelText: LanguageHelper.getAuthString('confirmPassword'),
          prefixIcon: SvgPicture.asset(AppConstants.passwordIcon, fit: BoxFit.none),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LanguageHelper.getErrorString('confirmPasswordRequired');
            }
            if (value != _passwordController.text) {
              return LanguageHelper.getErrorString('notEqualPasswordFields');
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          focusNode: _confirmPasswordFocusNode,
        ),
        SizedBox(height: 24.h),
        RichText(
          text: TextSpan(
            text: LanguageHelper.getAuthString('agreement2'),
            style: AppTheme.bodyText4,
            children: [
              TextSpan(
                text: LanguageHelper.getAuthString('agreement3'),
                style: AppTheme.bodyText5.copyWith(decoration: TextDecoration.underline),
              ),
              TextSpan(text: LanguageHelper.getAuthString('agreement'), style: AppTheme.bodyText4),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return CustomButton(
              text: LanguageHelper.getAuthString('register'),
              width: 324.h,
              height: 53.h,
              borderRadius: 18.h,
              onPressed: state is AuthLoading ? null : _register,
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
        Text(LanguageHelper.getAuthString('hasAccount'), style: AppTheme.bodyText4),
        TextButton(
          onPressed: () => NavigationService.goToLogin(context),
          child: Text(LanguageHelper.getAuthString('login'), style: AppTheme.bodyText5),
        ),
      ],
    );
  }
}
