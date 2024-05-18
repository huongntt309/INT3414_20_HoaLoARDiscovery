import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  // Constructor nhận vào tham số title
  CustomAppBar({required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: kToolbarHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                title == "AI Chatbot"
                    ? 'image/home/bg_app_bar_ai.png' // Hình nền khác khi title là "AIchatbot"
                    : 'image/home/bg_app_bar.png', // Hình nền mặc định
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AppBar(
          backgroundColor:
              const Color(0xFFE8D3B5).withOpacity(0.1), // Tạo độ mờ cho màu nền
          centerTitle: true,
          elevation: 0,
        ),
      ],
    );
  }
}
