import 'package:carousel_slider/carousel_controller.dart';
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
    Key? key,
    required this.languageData,
    required this.databaseItems,
  }) : super(key: key);

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
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xFFFDEEDB),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.languageData.isNotEmpty
                        ? widget.languageData[selectedLanguage]
                            ['discover_hoa_lo_prison']
                        : 'Discover Hoa Lo Prison',
                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    widget.languageData.isNotEmpty
                        ? widget.languageData[selectedLanguage]
                            ['choose_favorite_destination']
                        : 'Choose your favorite destination',
                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: widget.databaseItems?.map((item) {
                          int index = widget.databaseItems!.indexOf(item);
                          return CustomIndicator(
                            currentIndex: _currentIndex,
                            index: index,
                          );
                        }).toList() ??
                        [],
                  ),
                ),
                const SizedBox(height: 50),
                if (widget.databaseItems != null)
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      viewportFraction: 0.73,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      height: 490,
                      onPageChanged: (index, reason) {
                        _currentIndex = index;
                        setState(() {});
                      },
                    ),
                    items: widget.databaseItems!
                        .map((item) => ItemCard(
                              onTap: () {},
                              item: item,
                              selectedLanguage: selectedLanguage,
                            ))
                        .toList(),
                  )
                else
                  Center(
                    child: CircularProgressIndicator(), // Loading indicator
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
    Key? key,
    required this.currentIndex,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: currentIndex == index ? 80 : 30,
      height: 5,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: currentIndex == index ? Colors.orange : Colors.grey,
      ),
    );
  }
}
