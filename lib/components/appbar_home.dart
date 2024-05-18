import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  // Constructor nhận vào tham số title
  CustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.brown,
      title: Text(
        title,
        style: GoogleFonts.merriweather(
          textStyle: TextStyle(
            fontSize: 24,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
