import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shartflix/core/constants/app_constants.dart';
import 'package:shartflix/core/theme/app_theme.dart';
import 'package:shartflix/core/utils/size_utils.dart';
import 'package:shartflix/core/utils/language_helper.dart';
import 'package:shartflix/shared/widgets/custom_button.dart';

class LimitedOfferBottomSheet extends StatefulWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  State<LimitedOfferBottomSheet> createState() => _LimitedOfferBottomSheetState();
}

class _LimitedOfferBottomSheetState extends State<LimitedOfferBottomSheet> {
  int? selectedPackageIndex;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Container(
        height: 680.h,
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.h)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            children: [
              _buildTopLinearGradient(),
              _buildBottomLinearGradient(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 25.h),
                  Text(
                    LanguageHelper.getOfferString('limitedOfferTitle'),
                    style: AppTheme.headline1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.25.h,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    LanguageHelper.getOfferString('limitedOfferDesc'),
                    style: AppTheme.bodyText5.copyWith(height: 1.5.h),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 13.h),
                  _buildBonusesSection(),
                  SizedBox(height: 22.h),
                  _buildTokenPackagesSection(),
                  SizedBox(height: 18.h),
                  _buildViewAllTokensButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildBottomLinearGradient() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 133.65.h,
        width: 267.13.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(133.65.h)),
          boxShadow: [BoxShadow(color: AppTheme.secondaryColor, offset: Offset(0.h, 66.52.h), blurRadius: 216.25.h)],
        ),
      ),
    );
  }

  Align _buildTopLinearGradient() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 133.65.h,
        width: 217.39.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(133.65.h)),
          boxShadow: [BoxShadow(color: AppTheme.secondaryColor, offset: Offset(0.h, 83.74.h), blurRadius: 216.25.h)],
        ),
      ),
    );
  }

  Widget _buildBonusesSection() {
    return Container(
      padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 22.h, bottom: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24.h)),
        border: Border.all(color: AppTheme.textPrimaryColor.withAlpha(90), width: 1.h),
        gradient: RadialGradient(colors: [AppTheme.primaryColor.withAlpha(90), AppTheme.primaryColor.withAlpha(97)]),
      ),
      child: Column(
        children: [
          Text(LanguageHelper.getOfferString('bonuses'), style: AppTheme.bodyText1.copyWith(height: 1.26.h)),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildBonusItem(LanguageHelper.getOfferString('premiumAccount'), AppConstants.premiumAccount),
              ),
              Expanded(child: _buildBonusItem(LanguageHelper.getOfferString('moreMatch'), AppConstants.moreMatch)),
              Expanded(child: _buildBonusItem(LanguageHelper.getOfferString('highlights'), AppConstants.highlight)),
              Expanded(child: _buildBonusItem(LanguageHelper.getOfferString('moreLike'), AppConstants.moreLike)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBonusItem(String title, String icon) {
    return Column(
      children: [
        Container(
          width: 55.h,
          height: 55.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: AppTheme.textPrimaryColor),
              BoxShadow(color: AppTheme.bonusColor, spreadRadius: -0.9.h, blurRadius: 8.33.h),
            ],
          ),
          child: Image.asset(icon),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          maxLines: 2,
          style: AppTheme.bodyText5.copyWith(height: 1.5.h),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTokenPackagesSection() {
    return Column(
      children: [
        Text(LanguageHelper.getOfferString('unlockJetons'), style: AppTheme.bodyText1.copyWith(height: 1.26.h)),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 14.h),
                    Container(
                      width: 111.71.h,
                      height: 217.83.h,
                      decoration: BoxDecoration(
                        color: AppTheme.transparentColor,
                        border: Border.all(color: AppTheme.textPrimaryColor.withAlpha(60), width: 1.h),
                        borderRadius: BorderRadiusGeometry.circular(16.h),
                        gradient: RadialGradient(
                          center: const Alignment(-0.47, -0.70),
                          radius: 1.45,
                          colors: [AppTheme.bonusColor, AppTheme.secondaryColor],
                          stops: const [0.0, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(color: AppTheme.textPrimaryColor),
                          BoxShadow(color: AppTheme.bonusColor, spreadRadius: -0.1.h, blurRadius: 15),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 44.3.h),
                          Text(
                            '200',
                            style: AppTheme.bodyText1.copyWith(height: 1.26.h, decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            '330',
                            style: AppTheme.headline2.copyWith(
                              fontSize: 25.h,
                              fontWeight: FontWeight.w900,
                              height: 1.2.h,
                            ),
                          ),
                          Text(
                            LanguageHelper.getOfferString('jeton'),
                            style: AppTheme.bodyText1.copyWith(height: 1.26.h),
                          ),
                          SizedBox(height: 25.06.h),
                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(horizontal: 12.47.h),
                            child: Divider(color: AppTheme.textPrimaryColor.withAlpha(90)),
                          ),
                          SizedBox(height: 12.91.h),
                          Text(
                            '₺99,99',
                            style: AppTheme.bodyText1.copyWith(fontWeight: FontWeight.w900, height: 1.2.h),
                          ),
                          SizedBox(height: 1.17.h),
                          Text(
                            LanguageHelper.getOfferString('weeklyPer'),
                            style: AppTheme.bodyText5.copyWith(height: 1.5.h),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.36.h),
                      child: Container(
                        width: 61.h,
                        height: 25.h,
                        padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 15.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(24.h),
                          boxShadow: [
                            BoxShadow(color: AppTheme.textPrimaryColor),
                            BoxShadow(color: AppTheme.bonusColor, spreadRadius: -0.01.h, blurRadius: 8.33.h),
                          ],
                        ),
                        child: Text(
                          LanguageHelper.getOfferString('plus10'),
                          style: AppTheme.bodyText5.copyWith(height: 1.5.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 14.h),
                    Container(
                      width: 111.71.h,
                      height: 217.83.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.textPrimaryColor.withAlpha(90), width: 3.h),
                        borderRadius: BorderRadiusGeometry.circular(16.h),
                        gradient: RadialGradient(
                          center: const Alignment(-0.47, -0.70),
                          radius: 1.2,
                          colors: [AppTheme.jetonColor, AppTheme.secondaryColor],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 44.3.h),
                          Text(
                            '2.000',
                            style: AppTheme.bodyText1.copyWith(height: 1.26.h, decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            '3.375',
                            style: AppTheme.headline2.copyWith(
                              fontSize: 25.h,
                              fontWeight: FontWeight.w900,
                              height: 1.2.h,
                            ),
                          ),
                          Text(
                            LanguageHelper.getOfferString('jeton'),
                            style: AppTheme.bodyText1.copyWith(height: 1.26.h),
                          ),
                          SizedBox(height: 25.06.h),
                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(horizontal: 12.47.h),
                            child: Divider(color: AppTheme.textPrimaryColor.withAlpha(90)),
                          ),
                          SizedBox(height: 12.91.h),
                          Text(
                            '₺799,99',
                            style: AppTheme.bodyText1.copyWith(fontWeight: FontWeight.w900, height: 1.2.h),
                          ),
                          SizedBox(height: 1.17.h),
                          Text(
                            LanguageHelper.getOfferString('weeklyPer'),
                            style: AppTheme.bodyText5.copyWith(height: 1.5.h),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.36.h),
                      child: Container(
                        width: 61.h,
                        height: 25.h,
                        padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 14.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(24.h),
                          boxShadow: [
                            BoxShadow(color: AppTheme.textPrimaryColor),
                            BoxShadow(color: AppTheme.jetonColor, spreadRadius: -0.01.h, blurRadius: 8.33.h),
                          ],
                        ),
                        child: Text(
                          LanguageHelper.getOfferString('plus70'),
                          style: AppTheme.bodyText5.copyWith(height: 1.5.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 14.h),
                    Container(
                      width: 111.71.h,
                      height: 217.83.h,
                      decoration: BoxDecoration(
                        color: AppTheme.transparentColor,
                        border: Border.all(color: AppTheme.textPrimaryColor.withAlpha(60), width: 1.h),
                        borderRadius: BorderRadiusGeometry.circular(16.h),
                        boxShadow: [
                          BoxShadow(color: AppTheme.textPrimaryColor),
                          BoxShadow(color: AppTheme.bonusColor, spreadRadius: -0.1.h, blurRadius: 15),
                        ],
                        gradient: RadialGradient(
                          center: const Alignment(-0.47, -0.70),
                          radius: 1.45,
                          colors: [AppTheme.bonusColor, AppTheme.secondaryColor],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 44.3.h),
                          Text(
                            '1000',
                            style: AppTheme.bodyText1.copyWith(height: 1.26.h, decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            '1350',
                            style: AppTheme.headline2.copyWith(
                              fontSize: 25.h,
                              fontWeight: FontWeight.w900,
                              height: 1.2.h,
                            ),
                          ),
                          Text(
                            LanguageHelper.getOfferString('jeton'),
                            style: AppTheme.bodyText1.copyWith(height: 1.26.h),
                          ),
                          SizedBox(height: 25.06.h),
                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(horizontal: 12.47.h),
                            child: Divider(color: AppTheme.textPrimaryColor.withAlpha(90)),
                          ),
                          SizedBox(height: 12.91.h),
                          Text(
                            '₺399,99',
                            style: AppTheme.bodyText1.copyWith(fontWeight: FontWeight.w900, height: 1.2.h),
                          ),
                          SizedBox(height: 1.17.h),
                          Text(
                            LanguageHelper.getOfferString('weeklyPer'),
                            style: AppTheme.bodyText5.copyWith(height: 1.5.h),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.36.h),
                      child: Container(
                        width: 61.h,
                        height: 25.h,
                        padding: EdgeInsets.symmetric(vertical: 3.5.h, horizontal: 15.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(24.h),
                          boxShadow: [
                            BoxShadow(color: AppTheme.textPrimaryColor),
                            BoxShadow(color: AppTheme.bonusColor, spreadRadius: -0.01.h, blurRadius: 8.33.h),
                          ],
                        ),
                        child: Text(
                          LanguageHelper.getOfferString('plus35'),
                          style: AppTheme.bodyText5.copyWith(height: 1.5.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildViewAllTokensButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        variant: CustomButtonVariant.filled,
        height: 53.h,
        borderRadius: 18.h,
        backgroundColor: AppTheme.secondaryColor,
        text: LanguageHelper.getOfferString('showAll'),
        onPressed: () {},
      ),
    );
  }
}
