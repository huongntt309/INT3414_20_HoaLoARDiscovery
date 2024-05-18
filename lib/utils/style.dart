import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/size.dart';

Color background = const Color(0xFF000500);
Color userChat = const Color.fromARGB(255, 213, 174, 118);
Color resChat = const Color.fromARGB(255, 222, 198, 171);
Color chatColor = const Color.fromARGB(255, 138, 82, 71);
var brown = const Color(0xFF5D3D1C);
Color hintColor = const Color.fromARGB(255, 138, 98, 71);

TextStyle messageText = GoogleFonts.merriweather(color: brown, fontSize: small);
TextStyle appBarTitle = GoogleFonts.merriweather(color: brown, fontWeight: FontWeight.bold);
TextStyle hintText = GoogleFonts.merriweather(color: hintColor, fontSize: small);
TextStyle dateText = GoogleFonts.merriweather(color: brown, fontSize: 13);
TextStyle promptText = GoogleFonts.merriweather(color: brown, fontSize: small);