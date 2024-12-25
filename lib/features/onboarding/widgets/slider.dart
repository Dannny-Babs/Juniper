import 'package:flutter/material.dart';
import 'package:juniper/core/utils/colors.dart';
import 'package:juniper/core/utils/packages.dart';

class OnboardingSlide {
  final String title;
  final String description;
  final String image;

  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingSlideWidget extends StatelessWidget {
  final OnboardingSlide slide;

  const OnboardingSlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 64.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 26.sp,
                height: 1,
                fontWeight: FontWeight.w500,
                color: AppColors.neutral500,
                letterSpacing: -0.5),
          ),
          const SizedBox(height: 8),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.3,
                  color: Color(0xFF44445F),
                ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            slide.image,
            height: 280.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
