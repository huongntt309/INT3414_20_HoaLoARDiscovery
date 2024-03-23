import 'package:flutter/material.dart';
import 'navbar.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDEEDB), // Đặt màu nền cho toàn bộ màn hình
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Hoa Lo AR Discovery',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Căn giữa tiêu đề
        elevation: 0,
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Sơ đồ tham quan",
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage('image/map/map_vertical.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomNavbar(currentIndex: 1),
    );
  }
}
