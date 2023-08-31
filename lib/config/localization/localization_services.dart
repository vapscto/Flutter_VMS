import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import 'lang/en_us.dart';
import 'lang/kn_in.dart';

class LocalizationService extends Translations {
  // Default locale
  static const locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final langs = ['English', 'ಕನ್ನಡ'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('kn', 'IN'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // lang/en_us.dart
        'kn_IN': knIn, // lang/kn_IN.dart
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);

    // final box = GetStorage();
    localeServiceBox!.put('lng', lang);

    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? getLocaleFromLanguage(String lang) {
    for (int i = 0; i <= langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }

  String getSelectedLanguage() {
    String defaultLang;

    if (localeServiceBox!.get('lng') != null) {
      final val = localeServiceBox!.get('lng');

      defaultLang = val!;
    } else {
      defaultLang = "US";
    }

    return defaultLang;
  }

  Locale getCurrentLocale() {
    Locale defaultLocale;

    if (localeServiceBox!.get('lng') != null) {
      final locale = LocalizationService()
          .getLocaleFromLanguage(localeServiceBox!.get('lng'));

      defaultLocale = locale!;
    } else {
      defaultLocale = const Locale(
        'en',
        'US',
      );
    }

    return defaultLocale;
  }

  String getCurrentLang() {
    return (localeServiceBox!.get('lng') != null)
        ? localeServiceBox!.get('lng')
        : "English";
  }
}
