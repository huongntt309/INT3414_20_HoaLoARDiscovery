import 'package:animate_do/animate_do.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(onboardingList[_currentIndex].bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomGradientCard(
          gradient: AppColors.customOnboardingGradient,
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingCard(
                      onboarding: onboardingList[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomDotsIndicator(
                dotsCount: onboardingList.length,
                position: _currentIndex,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                onTap: () {
                  if (_currentIndex == onboardingList.length - 1) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  }
                },
                text: 'Continue',
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  const PrimaryButton({
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            height: widget.height ?? 50,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.color ?? AppColors.kPrimary,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                  color: widget.color == null ? AppColors.kWhite : Colors.black,
                  fontSize: widget.fontSize ?? 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingCard extends StatelessWidget {
  final Onboarding onboarding;
  const OnboardingCard({required this.onboarding, super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            onboarding.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.kWhite),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              onboarding.info,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.kWhite),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomGradientCard extends StatelessWidget {
  final Widget child;
  final LinearGradient gradient;
  const CustomGradientCard({
    required this.child,
    required this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: child,
    );
  }
}

class CustomDotsIndicator extends StatelessWidget {
  final int position;
  final int dotsCount;
  const CustomDotsIndicator({
    required this.dotsCount,
    required this.position,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: dotsCount,
      position: position,
      decorator: DotsDecorator(
        color: AppColors.kWhite,
        size: const Size.square(8.0),
        activeSize: const Size(24, 8),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        activeColor: AppColors.kPrimary,
      ),
    );
  }
}

class Onboarding {
  String bgImage;
  String title;
  String info;
  Onboarding({
    required this.bgImage,
    required this.title,
    required this.info,
  });
}

List<Onboarding> onboardingList = [
  Onboarding(
    bgImage: AppAssets.kOnboardingFirst,
    title: "Hỏa Lò AR Discovery",
    info:
        'Một dự án nhóm bài tập lớn môn Chuyên đề Công nghệ (INT3414_20) \n của Trường Đại học Công nghệ (UET-VNU). ',
  ),
  Onboarding(
    bgImage: AppAssets.kOnboardingSecond,
    title: 'Hỏa Lò AR Discovery',
    info:
        'Hỏa Lò AR Discovery sử dụng Thực tế tăng cường (AR) và Chatbot AI trong hướng dẫn tham quan các di tích của nhà tù Hỏa Lò, từ đó cải thiện trải nghiệm tham quan của các du khách.',
  ),
  Onboarding(
    bgImage: AppAssets.kOnboardingThird,
    title: "Hỏa Lò AR Discovery",
    info:
        'Nhà tù Hỏa Lò là biểu tượng cho tinh thần kiên cường, bất khuất của những người con Việt Nam yêu nước.\n Hãy cùng Hỏa Lò AR Discovery khám phá di tích nhà tù!',
  ),
];

class AppColors {
  static const Color kPrimary = Color(0xFFD1A661);
  static const Color kWhite = Color(0xFFFEFEFE);
  static LinearGradient customOnboardingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF110C1D).withOpacity(0.0),
      const Color(0xFF110C1D),
    ],
  );
}

class AppAssets {
  static String kOnboardingFirst = 'image/intro/1.jpg';
  static String kOnboardingSecond = 'image/intro/2.jpg';
  static String kOnboardingThird = 'image/intro/3.jpg';
}
