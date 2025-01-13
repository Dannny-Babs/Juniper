import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/button.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/slider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: "Find Your\nDream Apartment",
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
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(OnboardingStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.isCompleted) {
          GoRouter.of(context).go('/login');
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConstants.padding24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPagination(state.currentPage),
                        TextButton(
                          onPressed: () => context
                              .read<OnboardingBloc>()
                              .add(OnboardingSkipped()),
                          child: Row(
                            children: [
                              Text(
                                'Skip',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColors.neutral500,
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
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        itemCount: slides.length,
                        itemBuilder: (context, index) {
                          return OnboardingSlideWidget(slide: slides[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildButtons(state),
                    SizedBox(height: 15.sp),
                  ],
                ),
              ),
              if (state.isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPagination(int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        slides.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          width: currentIndex == index ? 30.0 : 5.0,
          height: 5.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: currentIndex == index ? AppColors.neutral500 : Colors.grey,
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(OnboardingState state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CustomButton(
      height: 48.sp,
      text: state.currentPage == slides.length - 1 ? 'Get Started' : 'Continue',
      backgroundColor:
          isDark ? AppColors.backgroundLight : AppColors.neutral800,
      textColor: isDark ? AppColors.neutral900 : AppColors.backgroundLight,
      size: ButtonSize.medium,
      isLoading: state.isLoading,
      onPressed: () {
        if (state.currentPage == slides.length - 1) {
          context.read<OnboardingBloc>().add(OnboardingCompleted());
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
