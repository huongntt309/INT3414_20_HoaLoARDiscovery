import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class CustomNavbarDetail extends StatelessWidget {
  final int currentIndex; // Thêm thuộc tính currentIndex

  const CustomNavbarDetail({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      onTap: (int val) {
        // Thực hiện điều hướng đến tab mới
        // Cập nhật currentIndex với giá trị của tab mới được chọn
        switch (val) {
          case 0:
            Navigator.pushReplacementNamed(context, '/detail');
            break;
          // case 1:
          //   Navigator.pushReplacementNamed(context, '/more');
          //   break;
          case 1:
            Navigator.pushReplacementNamed(context, '/video');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/ar');
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
        FloatingNavbarItem(icon: Icons.info, title: 'Detail'),
        FloatingNavbarItem(icon: Icons.video_camera_back, title: 'Video'),
        FloatingNavbarItem(icon: Icons.smartphone, title: 'AR'),
      ],
    );
  }
}
