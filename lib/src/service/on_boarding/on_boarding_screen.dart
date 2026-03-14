
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/constants/images.dart';
import '../../global/widget/global_image_loader.dart';
import '../../global/widget/global_sized_box.dart';
import '../../global/widget/global_text.dart';
import '../auth/view/login_screen.dart';
import 'container_space_back_widget.dart';

class OnBoardModel {
  String? img;
  String? text;
  String? subText;

  OnBoardModel(
      {required this.img, required this.text, required this.subText});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  int currentPageIndex = 0;
  String selectedLanguage = 'EN';
  late PageController _pageController;

  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _shimmerController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _shimmerAnimation;

  Map<String, List<OnBoardModel>> languageData = {
    'EN': [
      OnBoardModel(
        img: Images.onBoard3,
        text: "Smart EMI Shopping",
        subText:
        "Buy your dream electronics & mobiles with easy monthly installments. No stress, just smart buying.",
      ),
      OnBoardModel(
        img: Images.onBoard1,
        text: "Track Your Payments",
        subText:
        "Stay on top of all your EMI schedules, due dates and payment history — all in one place.",
      ),
      OnBoardModel(
        img: Images.onBoard2,
        text: "Get Started Today",
        subText:
        "Thousands of products await. Flexible plans, instant approval & doorstep delivery.",
      ),
    ],
    'BN': [
      OnBoardModel(
        img: Images.onBoard3,
        text: "স্মার্ট কিস্তিতে কেনাকাটা",
        subText:
        "সহজ মাসিক কিস্তিতে আপনার স্বপ্নের ইলেকট্রনিক্স ও মোবাইল কিনুন। ঝামেলামুক্ত, স্মার্ট কেনাকাটা।",
      ),
      OnBoardModel(
        img: Images.onBoard1,
        text: "পেমেন্ট ট্র্যাক করুন",
        subText:
        "আপনার সমস্ত কিস্তির সময়সূচী, নির্ধারিত তারিখ এবং পেমেন্ট ইতিহাস এক জায়গায় দেখুন।",
      ),
      OnBoardModel(
        img: Images.onBoard2,
        text: "আজই শুরু করুন",
        subText:
        "হাজারো পণ্য অপেক্ষা করছে। নমনীয় পরিকল্পনা, তাৎক্ষণিক অনুমোদন ও দরজায় ডেলিভারি।",
      ),
    ],
  };

  List<OnBoardModel> get images =>
      languageData[selectedLanguage] ?? languageData['EN']!;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOutSine),
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _floatingController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
    _slideController.forward();
    _shimmerController.repeat();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    _shimmerController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChange(int index) {
    setState(() {
      currentPageIndex = index;
    });
    _slideController.reset();
    _slideController.forward();
  }

  void _onNextPressed() {
    if (currentPageIndex < images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Get.offAll(() => const LogInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isLast = currentPageIndex == images.length - 1;

    return Scaffold(
      backgroundColor: ColorRes.appBackColor,
      body: ContainerSpaceBackWidget(
        child: SafeArea(
          child: Column(
            children: [
              // ── Top bar ──────────────────────────────────────────
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo/Brand chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: ColorRes.appColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ColorRes.appColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.electric_bolt_rounded,
                              size: 14, color: ColorRes.appColor),
                          const SizedBox(width: 5),
                          GlobalText(
                            str: 'EMI Store',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorRes.appColor,
                          ),
                        ],
                      ),
                    ),

                    // Language toggle
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ColorRes.appColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: ['EN', 'BN'].map((lang) {
                          final isSelected = selectedLanguage == lang;
                          return GestureDetector(
                            onTap: () => setState(() => selectedLanguage = lang),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorRes.appColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: GlobalText(
                                str: lang,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? Colors.white
                                    : ColorRes.appColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Page View ─────────────────────────────────────────
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: _onPageChange,
                  itemBuilder: (context, index) {
                    return _buildPage(context, index, h, w);
                  },
                ),
              ),

              // ── Bottom Section ─────────────────────────────────────
              _buildBottomSection(isLast),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(
      BuildContext context, int index, double h, double w) {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _slideAnimation]),
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Image card ──────────────────────────────────────
              Transform.translate(
                offset: Offset(0, _floatingAnimation.value),
                child: Transform.scale(
                  scale: 0.92 + (_slideAnimation.value * 0.08),
                  child: Opacity(
                    opacity: _slideAnimation.value,
                    child: _buildImageCard(index, h, w),
                  ),
                ),
              ),

              sizedBoxH(36),

              sizedBoxH(24),

              // ── Text content ────────────────────────────────────
              Transform.translate(
                offset: Offset(0, 20 * (1 - _slideAnimation.value)),
                child: Opacity(
                  opacity: _slideAnimation.value,
                  child: Column(
                    children: [
                      GlobalText(
                        str: images[index].text ?? '',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        textAlign: TextAlign.center,
                        color: ColorRes.appColor,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GlobalText(
                          str: images[index].subText ?? '',
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageCard(int index, double h, double w) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow ring
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) => Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              width: w * 0.72,
              height: w * 0.72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    ColorRes.appColor.withValues(alpha: 0.08),
                    ColorRes.appColor.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),

        // Card with image
        GlobalImageLoader(
          imagePath: images[index].img ?? '',
          fit: BoxFit.cover,
          width: double.infinity,
        ),

      ],
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(images.length, (index) {
        final isActive = index == currentPageIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? ColorRes.appColor
                : ColorRes.appColor.withValues(alpha: 0.2),
            boxShadow: isActive
                ? [
              BoxShadow(
                color: ColorRes.appColor.withValues(alpha: 0.4),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ]
                : null,
          ),
        );
      }),
    );
  }

  Widget _buildBottomSection(bool isLast) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        children: [
          // Skip row
          // if (!isLast)
          //   Padding(
          //     padding: const EdgeInsets.only(bottom: 14),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         GestureDetector(
          //           onTap: () => Get.offAll(() => const LogInScreen()),
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 16, vertical: 8),
          //             child: GlobalText(
          //               str: selectedLanguage == 'EN' ? 'Skip' : 'এড়িয়ে যান',
          //               fontSize: 13,
          //               fontWeight: FontWeight.w500,
          //               color: Colors.grey,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),

          // ── Step indicator strip ────────────────────────────
          _buildStepIndicator(),

          sizedBoxH(20),
          // Next / Get Started button
          GestureDetector(
            onTap: _onNextPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: [
                    ColorRes.appColor,
                    ColorRes.appColor.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorRes.appColor.withValues(alpha: 0.35),
                    blurRadius: 16,
                    spreadRadius: 0,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalText(
                    str: isLast
                        ? (selectedLanguage == 'EN'
                        ? 'Get Started'
                        : 'শুরু করুন')
                        : (selectedLanguage == 'EN' ? 'Next' : 'পরবর্তী'),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isLast
                          ? Icons.rocket_launch_rounded
                          : Icons.arrow_forward_rounded,
                      key: ValueKey(isLast),
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}