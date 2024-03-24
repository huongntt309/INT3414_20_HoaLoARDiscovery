import 'package:flutter/material.dart';

class CustomAppBarDetail extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomAppBarDetail({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.brown,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true, // Căn giữa tiêu đề
      elevation: 0,
    );
  }
}
