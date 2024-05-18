import 'package:flutter/material.dart';

class CustomAppBarDetail extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomAppBarDetail({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: kToolbarHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'image/home/bg_app_bar_detail.png'), // Thay đổi đường dẫn đến hình ảnh của bạn
              fit: BoxFit.cover,
            ),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true, // Căn giữa tiêu đề
          elevation: 0,
        ),
      ],
    );
  }
}
