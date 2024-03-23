import 'package:flutter/material.dart';
// import './widgets/intro.dart';
import 'package:hoa_lo_ar_discovery/widgets/intro.dart';
import 'package:hoa_lo_ar_discovery/widgets/home.dart';
import 'package:hoa_lo_ar_discovery/widgets/map.dart';
import 'package:hoa_lo_ar_discovery/widgets/setting.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/intro': (context) => IntroScreen(),
      '/home': (context) => HomeScreen(),
      '/map': (context) => MapScreen(),
      '/setting': (context) => SettingScreen(),
    },
  ));
}
