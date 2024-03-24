import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/components/appbar_detail.dart';
import 'package:hoa_lo_ar_discovery/components/navbar_detail.dart';
import 'package:hoa_lo_ar_discovery/utils/database_manager.dart';

class DetailScreen extends StatelessWidget {
  final DatabaseItem item;
  final String selectedLanguage;

  const DetailScreen(
      {Key? key, required this.item, required this.selectedLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sử dụng dữ liệu của item và language để hiển thị chi tiết mục
    Map<String, dynamic> itemTextData =
        selectedLanguage == 'Vietnamese' ? item.vietnamese : item.english;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBarDetail(title: itemTextData['name']),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xFFFDEEDB), // 0xFFFDEEDB
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phần hiển thị hình ảnh
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height *
                      0.4, // Chiếm 30% chiều cao của màn hình
                  child: Center(
                    // Căn giữa cả ngang và dọc
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.9, // Chiếm 90% chiều rộng của màn hình
                      height: double.infinity, // Chiều cao tự động theo cha
                      child: CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 16 / 9, // Thay đổi tỷ lệ khung hình
                          viewportFraction:
                              0.9, // Chiếm 80% chiều rộng của màn hình
                          enlargeCenterPage: true, // Phóng to ảnh ở giữa
                          autoPlay: true, // Tự động chuyển đổi giữa các ảnh
                          autoPlayInterval: Duration(
                              seconds:
                                  2), // Thời gian giữa các lần chuyển ảnh (3 giây)
                          autoPlayAnimationDuration: Duration(
                              milliseconds:
                                  800), // Thời gian chuyển đổi giữa các ảnh (800 milliseconds)
                        ),
                        items: item.images.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(15.0), // Bo góc
                                child: Image.asset(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),

              // Phần hiển thị văn bản
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 244, 208, 161), // Màu nền phần text
                      borderRadius: BorderRadius.circular(15), // Bo góc
                    ),
                    padding:
                        EdgeInsets.all(16.0), // Khoảng cách padding bao quanh
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            itemTextData['name'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown, // Màu chữ
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          itemTextData['detail'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black, // Màu chữ
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ], // Đóng cặp ngoặc của children
          ),
        ),
      ),

      bottomNavigationBar: CustomNavbarDetail(
        currentIndex: 0,
        databaseItem: item,
        language: selectedLanguage,
      ),
    );
  }
}
