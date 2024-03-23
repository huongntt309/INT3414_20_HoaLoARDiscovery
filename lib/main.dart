import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/utils/database_manager.dart';
import 'package:hoa_lo_ar_discovery/utils/language_manager.dart';
import './widgets/home.dart';
import './widgets/map.dart';
import './widgets/intro.dart';
import './widgets/setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Tải dữ liệu ngôn ngữ từ main
  await LanguageManager().loadLanguageData();

  // Load database
  await DatabaseManager().loadDatabase();

// Lấy dữ liệu ngôn ngữ
  Map<String, dynamic> languageData = LanguageManager().languageData;

  // Lấy danh sách databaseItems
  List<DatabaseItem> databaseItems = DatabaseManager().database;

  runApp(MyApp(languageData: languageData, databaseItems: databaseItems));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> languageData;
  final List<DatabaseItem> databaseItems;

  const MyApp(
      {Key? key, required this.languageData, required this.databaseItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/intro',
      routes: {
          '/intro': (context) => const IntroScreen(),
        '/home': (context) => HomeScreen(
            languageData: languageData, databaseItems: databaseItems),
        '/map': (context) => MapScreen(languageData: languageData),
        '/setting': (context) => SettingScreen(languageData: languageData),
      },
    );
  }
}
