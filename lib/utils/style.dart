import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/size.dart';

Color background = const Color(0xFF000500);
Color userChat = Color.fromARGB(255, 253, 223, 204);
Color resChat = Color.fromARGB(255, 255, 181, 139);
Color chatColor = Color.fromARGB(255, 138, 82, 71);
var brown = Color.fromARGB(255, 87, 33, 8);
Color hintColor = Color.fromARGB(255, 138, 98, 71);

TextStyle messageText = GoogleFonts.poppins(color: brown, fontSize: small);
TextStyle appBarTitle = GoogleFonts.poppins(color: brown, fontWeight: FontWeight.bold);
TextStyle hintText = GoogleFonts.poppins(color: hintColor, fontSize: small);
TextStyle dateText = GoogleFonts.poppins(color: brown, fontSize: 13);
TextStyle promptText = GoogleFonts.poppins(color: brown, fontSize: small);