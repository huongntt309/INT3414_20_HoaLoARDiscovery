import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import Hệ thống Services
import './widgets/home.dart'; // Import các màn hình của bạn
import './widgets/map.dart';
import './widgets/intro.dart';
import './widgets/setting.dart';
import './utils/language_manager.dart'; // Import LanguageManager

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageManager().loadLanguageData(); // Tải dữ liệu ngôn ngữ từ main
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => IntroScreen(),
        '/home': (context) => HomeScreen(),
        '/map': (context) => MapScreen(),
        '/setting': (context) => SettingScreen(),
      },
    );
  }
}
