import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../components/navbar_home.dart'; // Import navbar.dart
import '../components/appbar_home.dart'; // Import CustomAppBar
import '../utils/language_manager.dart'; // Import LanguageManager

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController? carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> languageData = LanguageManager()
        .languageData; // Lấy dữ liệu ngôn ngữ từ LanguageManager
    String selectedLanguage = LanguageManager()
        .selectedLanguage; // Lấy ngôn ngữ được chọn từ LanguageManager

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
                          languageData.isNotEmpty
                              ? languageData[selectedLanguage]
                                  ['discover_hoa_lo_prison']
                              : 'Discover Hoa Lo Prison',
                          style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 34,
                              fontWeight: FontWeight.w600))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                        languageData.isNotEmpty
                            ? languageData[selectedLanguage]
                                ['choose_favorite_destination']
                            : 'Choose your favorite destination',
                        style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 16,
                            fontWeight: FontWeight.w300)),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: samosaList.map((urlOfItem) {
                        int index = samosaList.indexOf(urlOfItem);
                        return CustomIndicator(
                          currentIndex: _currentIndex,
                          index: index,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 50),
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
                        }),
                    items: samosaList.map((i) {
                      return SamosaCard(
                        onTap: () {},
                        samosa: i,
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: const CustomNavbar(currentIndex: 0));
  }
}

class SamosaCard extends StatelessWidget {
  final VoidCallback onTap;
  final SamosaModel samosa;
  const SamosaCard({super.key, required this.onTap, required this.samosa});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        color: Colors.brown,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
            height: 455,
            width: 280,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.brown, borderRadius: BorderRadius.circular(20)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child: Container(
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(samosa.image),
                              fit: BoxFit.cover)))),
              Text(samosa.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              Text(samosa.description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w200)),
              const Spacer(),
              ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: const Size(double.maxFinite, 44)),
                  child: Text(
                    "View Details",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ))
            ])));
  }
}

class CustomIndicator extends StatelessWidget {
  final int currentIndex;
  final int index;
  const CustomIndicator(
      {super.key, required this.currentIndex, required this.index});

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

class SamosaModel {
  String image;
  String title;
  String description;
  SamosaModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

String longText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
List<SamosaModel> samosaList = [
  SamosaModel(
      image: 'image/intro/intro2.png',
      title: 'Chinese Samosa',
      description: longText),
  SamosaModel(
      image: 'image/intro/intro2.png',
      title: 'Indian Samosa',
      description: longText),
  SamosaModel(
      image: 'image/intro/intro2.png',
      title: 'Pakistani Samosa',
      description: longText)
];
