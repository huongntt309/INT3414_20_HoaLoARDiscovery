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
  VoidCallback? _languageChangeCallback;

  String get selectedLanguage => _selectedLanguage;

  set selectedLanguage(String language) {
    _selectedLanguage = language;
    // Gọi hàm callback để thông báo về sự thay đổi ngôn ngữ
    if (_languageChangeCallback != null) {
      _languageChangeCallback!();
    }
  }

  Map<String, dynamic> get languageData => _languageData;

  Future<void> loadLanguageData() async {
    String data = await rootBundle.loadString('languages/language.json');
    _languageData = json.decode(data);
  }

  void setLanguageChangeCallback(VoidCallback callback) {
    _languageChangeCallback = callback;
  }
}
