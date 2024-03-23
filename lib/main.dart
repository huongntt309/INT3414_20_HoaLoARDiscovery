import 'package:flutter/material.dart';
// import './widgets/intro.dart';
import 'package:hoa_lo_ar_discovery/widgets/intro.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/intro',
    routes: {
      '/intro': (context) => IntroScene(),
      // '/home': (context) => Home(),
    },
  ));
}
