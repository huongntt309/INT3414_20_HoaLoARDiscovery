import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/utils/database_manager.dart';
import '../components/navbar_home.dart'; // Import navbar.dart
import '../components/appbar_home.dart'; // Import CustomAppBar
import '../components/item_card.dart'; // Import ItemCard
import 'package:hoa_lo_ar_discovery/utils/language_manager.dart'; // Import LanguageManager

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> languageData;
  final List<DatabaseItem> databaseItems;

  const HomeScreen({
    super.key,
    required this.languageData,
    required this.databaseItems,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController? carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Đăng ký hàm callback để cập nhật ngôn ngữ khi thay đổi
    LanguageManager().setLanguageChangeCallback(_handleLanguageChange);
  }

  // Hàm callback để xử lý sự thay đổi ngôn ngữ
  void _handleLanguageChange() {
    setState(() {
      // Refresh UI khi người dùng thay đổi ngôn ngữ
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedLanguage = LanguageManager().selectedLanguage;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Hoa Lo AR Discovery'),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: const Color(0xFFFDEEDB),
        decoration: const BoxDecoration(
          color: Color(0xFFFDEEDB),
          image: DecorationImage(
            image: AssetImage(
                'assets/image/home/bg_home.jpg'), // Thay đường dẫn tới hình ảnh của bạn
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.languageData.isNotEmpty
                        ? widget.languageData[selectedLanguage]
                            ['discover_hoa_lo_prison']
                        : 'Discover Hoa Lo Prison',
                    style: const TextStyle(
                      color: Color(0xFF5D3D1C),
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.languageData.isNotEmpty
                        ? widget.languageData[selectedLanguage]
                            ['choose_favorite_destination']
                        : 'Choose your favorite destination',
                    style: const TextStyle(
                      color: Color(0xFF5D3D1C),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: widget.databaseItems.map((item) {
                      int index = widget.databaseItems.indexOf(item);
                      return CustomIndicator(
                        currentIndex: _currentIndex,
                        index: index,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(),
                CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    viewportFraction: 0.73,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    height: 480,
                    onPageChanged: (index, reason) {
                      _currentIndex = index;
                      setState(() {});
                    },
                  ),
                  items: widget.databaseItems
                      .map((item) => ItemCard(
                            onTap: () {},
                            item: item,
                            selectedLanguage: selectedLanguage,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: const CustomNavbar(currentIndex: 0),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final int currentIndex;
  final int index;

  const CustomIndicator({
    super.key,
    required this.currentIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: currentIndex == index ? 40 : 15,
      height: 5,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: currentIndex == index ? Colors.orange : Colors.grey,
      ),
    );
  }
}
