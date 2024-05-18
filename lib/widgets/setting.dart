import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/components/appbar_home.dart';
import '../components/navbar_home.dart';
import '../utils/language_manager.dart'; // Import LanguageManager

class SettingScreen extends StatefulWidget {
  final Map<String, dynamic> languageData;

  const SettingScreen({Key? key, required this.languageData}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = LanguageManager().selectedLanguage;
  }

  // Hàm xử lý sự kiện khi người dùng nhấn nút xác nhận
  void _handleConfirmation() {
    setState(() {
      LanguageManager().selectedLanguage = _selectedLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.languageData.isNotEmpty
                      ? widget.languageData[_selectedLanguage]['setting']
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
                          widget.languageData.isNotEmpty
                              ? widget.languageData[_selectedLanguage]
                                  ['language']
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
                        });
                      },
                      items: widget.languageData.isNotEmpty
                          ? widget.languageData.keys.map((language) {
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
      bottomNavigationBar: CustomNavbar(currentIndex: 3),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleConfirmation,
        label: Text(
          widget.languageData.isNotEmpty
              ? widget.languageData[_selectedLanguage]['confirm']
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
