import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button.dart';

enum ProfileSetupStage {
  personal,
  preferences,
  lifestyle,
  finalTouches;

  String get title {
    switch (this) {
      case ProfileSetupStage.personal:
        return "Let's start with the basics";
      case ProfileSetupStage.preferences:
        return "What are you looking for?";
      case ProfileSetupStage.lifestyle:
        return "Let's personalize your experience";
      case ProfileSetupStage.finalTouches:
        return "You're almost done!";
    }
  }

  String get subtitle {
    switch (this) {
      case ProfileSetupStage.personal:
        return "Tell us about yourself so we can create your profile";
      case ProfileSetupStage.preferences:
        return "We'll use this to find the best matches for you";
      case ProfileSetupStage.lifestyle:
        return "What matters most to you in a home or investment?";
      case ProfileSetupStage.finalTouches:
        return "Add a finishing touch to your profile";
    }
  }
}

class ProfileStepper extends StatelessWidget {
  final ProfileSetupStage currentStage;
  final Widget child;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isLastStep;

  const ProfileStepper({
    super.key,
    required this.currentStage,
    required this.child,
    required this.onNext,
    this.onBack,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: onBack != null
            ? PlatformBackButton(
                onPressed: () => onBack?.call(),
                color: AppColors.neutral500,
              )
            : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.sp),
                LinearProgressIndicator(
                  value: (ProfileSetupStage.values.indexOf(currentStage) + 1) /
                      ProfileSetupStage.values.length,
                  borderRadius: BorderRadius.circular(8.sp),
                  backgroundColor: AppColors.neutral200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary500,
                  ),
                ),
                SizedBox(height: 24.sp),
                Text(
                  'Step ${ProfileSetupStage.values.indexOf(currentStage) + 1} of ${ProfileSetupStage.values.length}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.neutral500
                            : AppColors.neutral500,
                        fontSize: 14.sp,
                      ),
                ),
                SizedBox(height: 12.sp),
                Text(
                  currentStage.title,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontFamily: 'HelveticaNeue',
                        color: isDark
                            ? AppColors.neutral300
                            : AppColors.neutral900,
                        fontWeight: FontWeight.w500,
                        fontSize: 26.sp,
                        letterSpacing: -0.5,
                      ),
                ),
                SizedBox(height: 4.sp),
                Text(
                  currentStage.subtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontFamily: 'HelveticaNeue',
                        color: AppColors.neutral500,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        fontSize: 16.sp,
                        letterSpacing: -0.1,
                      ),
                ),
                SizedBox(height: 32.sp),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.sp),
              child: child,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.sp),
            child: CustomButton(
              backgroundColor:
                  isDark ? AppColors.neutral800 : AppColors.neutral700,
              height: 48.sp,
              width: double.infinity,
              onPressed: onNext,
              text: isLastStep ? 'Complete Profile' : 'Continue',
              size: ButtonSize.medium,
            ),
          ),
        ],
      ),
    );
  }
}
