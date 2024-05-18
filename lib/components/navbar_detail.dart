import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:hoa_lo_ar_discovery/utils/database_manager.dart';
import 'package:hoa_lo_ar_discovery/widgets/detail.dart';
import 'package:hoa_lo_ar_discovery/widgets/video.dart';

class CustomNavbarDetail extends StatelessWidget {
  final int currentIndex; // Thêm thuộc tính currentIndex
  final DatabaseItem databaseItem; // Thêm thuộc tính databaseItem
  final String language; // Thêm thuộc tính language

  const CustomNavbarDetail({
    Key? key,
    required this.currentIndex,
    required this.databaseItem, // Thêm vào constructor
    required this.language, // Thêm vào constructor
  }) : super(key: key);

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    item: databaseItem,
                    selectedLanguage: language,
                  ),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoDetailScreen(
                    item: databaseItem,
                    selectedLanguage: language,
                  ),
                ),
              );
              break;
            // case 2:
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ARScreen(
            //         item: databaseItem,
            //         selectedLanguage: language,
            //       ),
            //     ),
            //   );
            //   break;
            default:
              break;
          }
        },
        // margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        selectedBackgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF5D3D1C),

        currentIndex:
            currentIndex, // Sử dụng currentIndex để xác định tab nào được chọn
        items: [
          FloatingNavbarItem(icon: Icons.info, title: 'Detail'),
          FloatingNavbarItem(icon: Icons.video_camera_back, title: 'Video'),
          FloatingNavbarItem(icon: Icons.smartphone, title: 'AR'),
        ],
      ),
    );
  }
}
