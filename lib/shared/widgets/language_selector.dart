import 'package:flutter/material.dart';
import '../../core/services/localization_service.dart';
import '../../core/utils/language_helper.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language, color: Colors.white),
      onSelected: (String languageCode) async {
        await LocalizationService().setLocale(Locale(languageCode));
      },
      itemBuilder: (BuildContext context) {
        return LanguageHelper.getSupportedLanguages().map((language) {
          return PopupMenuItem<String>(
            value: language['code']!,
            child: Row(
              children: [
                Text(language['flag']!),
                const SizedBox(width: 8),
                Text(language['name']!),
              ],
            ),
          );
        }).toList();
      },
    );
  }
} 