import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/button.dart';
import '../widgets/slider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: "Find Your\n Dream Apartment",
      description:
          "Your one-stop app for finding apartments, tracking investments, and managing properties effortlessly",
      image: "assets/images/onboarding-2.png",
    ),
    OnboardingSlide(
      title: "Smarter Investments, Simplified",
      description:
          "Track market trends and make informed real estate decisions with AI-powered insights.",
      image: "assets/images/onboarding-3.png",
    ),
    OnboardingSlide(
      title: "Your Favorites,\nAlways Handy",
      description:
          "Save the listings you love and revisit them anytime, all in one convenient place.",
      image: "assets/images/onboarding-4.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPagination(),
                TextButton( 
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Row(
                    children: [
                      Text(
                        'Skip',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.neutral500.withAlpha(230),
                          fontSize: 14.sp,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.neutral500,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingSlideWidget(slide: slides[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildButtons(),
            SizedBox(height: 15.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        slides.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          width: _currentIndex == index ? 30.0 : 5.0,
          height: 5.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: _currentIndex == index ? AppColors.neutral500 : Colors.grey,
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return CustomButton(
      height: 48.sp,
      text: _currentIndex == slides.length - 1 ? 'Get Started' : 'Continue',
      backgroundColor: AppColors.neutral500,
      textColor: AppColors.neutral100,
      size: ButtonSize.medium,
      onPressed: () {
        if (_currentIndex == slides.length - 1) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }
}
