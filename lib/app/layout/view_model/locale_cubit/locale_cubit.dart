import 'package:bloc/bloc.dart';
import 'package:egy_eye_admin/helpers/localization/lang_cache_helper.dart';
import 'package:flutter/material.dart';
import 'locale_states.dart';


class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('en')));

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
    await LanguageCacheHelper().getCachedLanguageCode();

    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    isArabic= !isArabic;
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }

  bool isArabic=false;
  List<String> languages=['العربية', 'English'];

}