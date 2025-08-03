import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/app_theme.dart';

class AppTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String data;

  const AppTextButton({super.key, required this.onPressed, required this.data});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(data, style: AppTheme.bodyText5.copyWith(decoration: TextDecoration.underline,)),
    );
  }
}
