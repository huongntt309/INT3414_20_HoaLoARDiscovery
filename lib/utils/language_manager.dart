import 'dart:convert';
import 'package:flutter/services.dart';

class LanguageManager {
  static final LanguageManager _instance = LanguageManager._internal();

  factory LanguageManager() {
    return _instance;
  }

  LanguageManager._internal();

  String _selectedLanguage = 'Vietnamese';
  Map<String, dynamic> _languageData = {};

  String get selectedLanguage => _selectedLanguage;

  set selectedLanguage(String language) {
    _selectedLanguage = language;
  }

  Map<String, dynamic> get languageData => _languageData;

  Future<void> loadLanguageData() async {
    String data = await rootBundle.loadString('languages/language.json');
    _languageData = json.decode(data);
  }
}
