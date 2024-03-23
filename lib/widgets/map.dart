import 'package:flutter/material.dart';
import '../components/navbar_home.dart';
import '../components/appbar_home.dart';
import '../utils/language_manager.dart'; // Import LanguageManager

class MapScreen extends StatefulWidget {
  final Map<String, dynamic>  languageData;

  const MapScreen({Key? key, required this.languageData}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    String selectedLanguage = LanguageManager().selectedLanguage; // Lấy ngôn ngữ được chọn từ LanguageManager

    return Scaffold(
      backgroundColor: Color(0xFFFDEEDB),
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                     widget.languageData.isNotEmpty
                        ?  widget.languageData[selectedLanguage]['tour_map']
                        : 'Tour Map', // Sử dụng dữ liệu ngôn ngữ từ LanguageManager
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage('image/map/map_vertical.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomNavbar(currentIndex: 1),
    );
  }
}