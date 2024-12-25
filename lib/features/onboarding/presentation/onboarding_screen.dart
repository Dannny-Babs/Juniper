import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/button.dart';
import '../widgets/slider.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: "Find Your Dream Apartment",
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
      title: "Your Favorites, Always Handy",
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
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16.0,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray500,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
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
      width: double.infinity,
      text: _currentIndex == slides.length - 1 ? 'Get Started' : 'Continue',
      backgroundColor: AppColors.neutral500,
      textColor: AppColors.neutral100,
      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 15.6.sp,
            letterSpacing: -0.24,
            fontWeight: FontWeight.w400

       
          ),
      onPressed: () {
        if (_currentIndex == slides.length - 1) {
          Navigator.pushReplacementNamed(context, '/get-started');
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
