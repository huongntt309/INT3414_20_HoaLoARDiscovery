import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/components/appbar_detail.dart';
import 'package:hoa_lo_ar_discovery/components/navbar_detail.dart';
import 'package:hoa_lo_ar_discovery/utils/database_manager.dart';
import 'package:hoa_lo_ar_discovery/components/video_player_widget.dart'; // Import VideoPlayerWidget

class VideoDetailScreen extends StatelessWidget {
  final DatabaseItem item;
  final String selectedLanguage;

  const VideoDetailScreen(
      {Key? key, required this.item, required this.selectedLanguage})
      : super(key: key);

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
        color: const Color(0xFFFDEEDB),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phần hiển thị video
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Bo góc
                  child: AspectRatio(
                    aspectRatio: 16 / 9,// Tỉ lệ khung hình của video, có thể điều chỉnh tùy thích
                    child: VideoPlayerHelper(videoPath: item.video),
                    ),
                  ),
                ),
              ),
              // Phần hiển thị văn bản
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 208, 161),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            itemTextData['video_title'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          itemTextData['video_detail'],
                          style: TextStyle(
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
