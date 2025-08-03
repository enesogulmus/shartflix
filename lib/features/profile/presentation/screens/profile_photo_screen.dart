import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shartflix/core/constants/app_constants.dart';
import 'package:shartflix/core/services/navigation_service.dart';
import 'package:shartflix/core/utils/size_utils.dart';
import 'package:shartflix/shared/widgets/custom_button.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/language_helper.dart';
import '../../bloc/profile_bloc.dart';

class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({super.key});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? _selectedImage;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40.h),
                    _buildTitle(),
                    SizedBox(height: 20.h),
                    _buildDescription(),
                    SizedBox(height: 40.h),
                    _buildImagePreview(),
                    const Spacer(),
                    _buildContinueButton(),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: Row(
        children: [
          CustomButton(
            variant: CustomButtonVariant.outlined,
            height: 44.h,
            width: 44.h,
            onPressed: () => NavigationService.goToMain(context),
            borderRadius: 22.h,
            backgroundColor: AppTheme.textPrimaryColor.withAlpha(20),
            borderColor: AppTheme.textSecondaryColor,
            padding: EdgeInsets.zero,
            child: SvgPicture.asset(AppConstants.backIcon, fit: BoxFit.none),
          ),
          Spacer(flex: 8),
          Text(LanguageHelper.getProfileString('profileDetail'), style: AppTheme.bodyText1),
          Spacer(flex: 8),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(LanguageHelper.getPhotoString('uploadPhotos'), style: AppTheme.headline2, textAlign: TextAlign.center);
  }

  Widget _buildDescription() {
    return Text(
      'Resources out incentivize relaxation floor loss cc.',
      maxLines: 2,
      style: AppTheme.bodyText2.copyWith(color: AppTheme.textPrimaryColor, height: 1.5),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildImagePreview() {
    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: Container(
        width: 169.h,
        height: 164.h,
        decoration: BoxDecoration(
          color: AppTheme.textPrimaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(16.h),
          border: Border.all(color: AppTheme.textPrimaryColor.withAlpha(10), width: 1.55.h),
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(14.h),
                child: Image.file(_selectedImage!, fit: BoxFit.cover),
              )
            : SvgPicture.asset(AppConstants.plusIcon, fit: BoxFit.none),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        variant: CustomButtonVariant.filled,
        height: 56.h,
        borderRadius: 18.h,
        backgroundColor: _selectedImage != null ? AppTheme.secondaryColor : AppTheme.textSecondaryColor.withAlpha(100),
        text: _isLoading ? LanguageHelper.getCommonString('loading') : LanguageHelper.getCommonString('continue'),
        textColor: AppTheme.backgroundColor,
        fontSize: AppTheme.bodyText1.fontSize,
        fontWeight: AppTheme.bodyText1.fontWeight,
        onPressed: _selectedImage != null && !_isLoading ? _uploadImage : null,
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 50,
      );

      if (image != null) {
        final file = File(image.path);
        final fileSize = await file.length();
        final maxSize = 1 * 1024 * 1024;

        if (fileSize > maxSize) {
          _showErrorSnackBar(LanguageHelper.getErrorString('fileSize'));
          return;
        }

        setState(() {
          _selectedImage = file;
        });
      }
    } catch (e) {
      _showErrorSnackBar(LanguageHelper.getErrorString('genericError'));
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.h))),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.h,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppTheme.textSecondaryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(2.h),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              LanguageHelper.getPhotoString('selectPhoto'),
              style: AppTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    variant: CustomButtonVariant.outlined,
                    height: 50.h,
                    borderRadius: 12.h,
                    borderColor: AppTheme.textSecondaryColor,
                    backgroundColor: AppTheme.backgroundColor,
                    text: LanguageHelper.getProfileString('importGallery'),
                    fontSize: AppTheme.bodyText2.fontSize,
                    fontWeight: AppTheme.bodyText2.fontWeight,
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImageFromGallery();
                    },
                  ),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: CustomButton(
                    variant: CustomButtonVariant.filled,
                    height: 50.h,
                    borderRadius: 12.h,
                    backgroundColor: AppTheme.secondaryColor,
                    text: LanguageHelper.getProfileString('importCamera'),
                    textColor: AppTheme.backgroundColor,
                    fontSize: AppTheme.bodyText2.fontSize,
                    fontWeight: AppTheme.bodyText2.fontWeight,
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImageFromCamera();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 50,
      );

      if (image != null) {
        final file = File(image.path);
        final fileSize = await file.length();
        final maxSize = 1 * 1024 * 1024;

        if (fileSize > maxSize) {
          _showErrorSnackBar(LanguageHelper.getErrorString('fileSize'));
          return;
        }

        setState(() {
          _selectedImage = file;
        });
      }
    } catch (e) {
      _showErrorSnackBar(LanguageHelper.getErrorString('genericError'));
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      context.read<ProfileBloc>().add(UpdateProfileImage(_selectedImage!.path));
      context.read<ProfileBloc>().add(RefreshProfileData());
      NavigationService.goToMain(context);
      _showSuccessSnackBar(LanguageHelper.getProfileString('successUploadPhoto'));
    } catch (e) {
      _showErrorSnackBar(LanguageHelper.getErrorString('genericError'));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: AppTheme.errorColor));
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: AppTheme.secondaryColor));
  }
}
