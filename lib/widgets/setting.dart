import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/components/appbar_home.dart';
import '../components/navbar_home.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../utils/language_manager.dart'; // Import LanguageManager

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _selectedLanguage = LanguageManager()
      .selectedLanguage; // Sử dụng giá trị đã chọn từ LanguageManager

  // Hàm xử lý sự kiện khi người dùng nhấn nút xác nhận
  void _handleConfirmation() {
    setState(() {
      LanguageManager().selectedLanguage = _selectedLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> languageData = LanguageManager()
        .languageData; // Lấy dữ liệu ngôn ngữ từ LanguageManager

    return Scaffold(
      backgroundColor: Color(0xFFFDEEDB),
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  languageData.isNotEmpty
                      ? languageData[_selectedLanguage]['setting']
                      : 'Setting',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.language, color: Colors.brown),
                        SizedBox(width: 8),
                        Text(
                          languageData.isNotEmpty
                              ? languageData[_selectedLanguage]['language']
                              : 'Language',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField(
                      value: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value.toString();
                          LanguageManager().selectedLanguage =
                              _selectedLanguage;
                        });
                      },
                      items: languageData.isNotEmpty
                          ? languageData.keys.map((language) {
                              return DropdownMenuItem(
                                value: language,
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Text(language),
                                  ],
                                ),
                              );
                            }).toList()
                          : [],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomNavbar(currentIndex: 2),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleConfirmation,
        label: Text(
          languageData.isNotEmpty
              ? languageData[_selectedLanguage]['confirm']
              : 'Xác nhận',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.check, color: Colors.white),
        backgroundColor: Colors.brown,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
