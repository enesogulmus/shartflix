import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/app_theme.dart';
import 'package:shartflix/core/utils/size_utils.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.obscureText,
    required this.textInputAction,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      child: TextFormField(
        autocorrect: false,
        onTapOutside: (event) => focusNode.unfocus(),
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: AppTheme.inputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        style: AppTheme.bodyText4,
        validator: validator,
      ),
    );
  }
}
