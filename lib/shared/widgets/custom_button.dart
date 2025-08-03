import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/app_theme.dart';
import 'package:shartflix/core/utils/size_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.variant,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.isEnabled,
    this.state,
    this.child,
    this.padding,
  });

  final String? text;
  final VoidCallback? onPressed;
  final CustomButtonVariant? variant;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isEnabled;
  final bool? state;
  final Widget? child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final effectiveVariant = variant ?? CustomButtonVariant.filled;
    final effectiveWidth = width ?? 111.h;
    final effectiveHeight = height ?? 33.h;
    final effectiveBorderRadius = borderRadius ?? 16.h;

    final effectiveIsEnabled = isEnabled ?? true;

    switch (effectiveVariant) {
      case CustomButtonVariant.filled:
        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: ElevatedButton(
            onPressed: effectiveIsEnabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? AppTheme.secondaryColor,
              foregroundColor: textColor ?? AppTheme.textPrimaryColor,
              disabledBackgroundColor: AppTheme.secondaryColor.withAlpha(128),
              disabledForegroundColor: AppTheme.textPrimaryColor.withAlpha(128),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(effectiveBorderRadius)),
              padding: padding??EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
            ),
            child: text != null
                ? _getState()
                      ? _buildLoading()
                      : Text(text ?? '', style: AppTheme.bodyText1, textAlign: TextAlign.center)
                : _getState()
                ? _buildLoading()
                : child,
          ),
        );

      case CustomButtonVariant.outlined:
        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: OutlinedButton(
            onPressed: effectiveIsEnabled ? onPressed : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: textColor ?? AppTheme.textPrimaryColor,
              disabledForegroundColor: AppTheme.textPrimaryColor.withAlpha(128),
              backgroundColor: backgroundColor ?? AppTheme.transparentColor,
              side: BorderSide(
                color: effectiveIsEnabled
                    ? (borderColor ?? AppTheme.textPrimaryColor)
                    : (borderColor ?? AppTheme.textPrimaryColor).withAlpha(128),
                width: 1,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(effectiveBorderRadius)),
              padding: padding ?? EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
            ),
            child: text != null
                ? _getState()
                      ? _buildLoading()
                      : Text(text ?? '', style: AppTheme.bodyText6, textAlign: TextAlign.center)
                : _getState()
                ? _buildLoading()
                : child,
          ),
        );
      case CustomButtonVariant.bottom:
        return SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: OutlinedButton(
            onPressed: effectiveIsEnabled ? onPressed : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: textColor ?? AppTheme.textPrimaryColor,
              backgroundColor: AppTheme.transparentColor,
              side: BorderSide(color: (borderColor ?? AppTheme.textPrimaryColor).withAlpha(128), width: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(effectiveBorderRadius)),
              padding: padding ?? EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
            ),
            child: child,
          ),
        );
    }
  }

  bool _getState() => (state ?? false);

  SizedBox _buildLoading() {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
    );
  }
}

enum CustomButtonVariant { filled, outlined, bottom }
