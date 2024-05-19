import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/components/appbar_detail.dart';
import 'package:hoa_lo_ar_discovery/components/navbar_detail.dart';
import 'package:hoa_lo_ar_discovery/utils/database_manager.dart';
import 'package:hoa_lo_ar_discovery/components/video_player_widget.dart'; // Import VideoPlayerWidget

class VideoDetailScreen extends StatelessWidget {
  final DatabaseItem item;
  final String selectedLanguage;

  const VideoDetailScreen(
      {super.key, required this.item, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    // Sử dụng dữ liệu của item và language để hiển thị chi tiết mục
    Map<String, dynamic> itemTextData =
        selectedLanguage == 'Vietnamese' ? item.vietnamese : item.english;
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBarDetail(title: itemTextData['name']),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: const Color(0xFFFDEEDB),
        decoration: const BoxDecoration(
          color: Color(0xFFFDEEDB),
          image: DecorationImage(
            image: AssetImage(
                'assets/image/home/bg_detail.jpg'), // Thay đường dẫn tới hình ảnh của bạn
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phần hiển thị video
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Bo góc
                    child: AspectRatio(
                      aspectRatio: 16 /
                          9, // Tỉ lệ khung hình của video, có thể điều chỉnh tùy thích
                      child: VideoPlayerHelper(videoPath: item.video),
                    ),
                  ),
                ),
              ),
              // Phần hiển thị văn bản
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 208, 161),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            itemTextData['video_title'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D3D1C),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          itemTextData['video_detail'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbarDetail(
        currentIndex: 1,
        databaseItem: item,
        language: selectedLanguage,
      ),
    );
  }
}
