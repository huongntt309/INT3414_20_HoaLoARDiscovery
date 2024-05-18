import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex; // Thêm thuộc tính currentIndex

  const CustomNavbar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.114,
      child: FloatingNavbar(
        onTap: (int val) {
          // Thực hiện điều hướng đến tab mới
          // Cập nhật currentIndex với giá trị của tab mới được chọn
          switch (val) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/ai-chatbot');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/map');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/setting');
              break;
            default:
              break;
          }
        },
        // margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        selectedBackgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.brown,
        currentIndex:
            currentIndex, // Sử dụng currentIndex để xác định tab nào được chọn
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.chat, title: 'AI chatbot'),
          FloatingNavbarItem(icon: Icons.map, title: 'Map'),
          FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
        ],
      ),
    );
  }
}
