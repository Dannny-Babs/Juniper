import 'package:flutter/material.dart';
import 'package:juniper/features/authentication/presentation/widgets/privacy.dart';
import 'package:juniper/features/authentication/presentation/widgets/register_form.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button.dart';
import '../widgets/socialsignup_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: PlatformBackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: AppColors.neutral500,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.sp),
                Text(
                  'Create an account',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontFamily: 'HelveticaNeue',
                        color: isDarkMode
                            ? AppColors.neutral50
                            : AppColors.neutral900,
                        fontWeight: FontWeight.w500,
                        fontSize: 26.sp,
                        letterSpacing: -0.5,
                      ),
                ),
                SizedBox(height: 6.sp),
                Text(
                  'Sign up to find your dream apartment or manage your property investments effortlessly.',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.normal,
                        color: isDarkMode
                            ? AppColors.neutral200
                            : AppColors.neutral800,
                        height: 1.3,
                        fontSize: 16.sp,
                        letterSpacing: -0.1,
                      ),
                ),
                SizedBox(height: 32.sp),
                RegisterForm(formKey: formKey),
                const SizedBox(height: 16),
                CustomButton(
                  height: 48.sp,
                  text: 'Create Account',
                  backgroundColor: isDarkMode
                      ? AppColors.backgroundLight
                      : AppColors.neutral800,
                  textColor: isDarkMode
                      ? AppColors.neutral900
                      : AppColors.backgroundLight,
                  size: ButtonSize.medium,
                  isLoading:
                      false, // You may want to bind this to a state variable
                  onPressed: () {
                    //  if (formKey.currentState!.validate()) {
                    // Do something
                    context.push('/otp');
                    //}
                  },
                ),
                SizedBox(height: 24.sp),
                _buildDivider(context),
                SizedBox(height: 24.sp),
                SocialSignUpButton(),
                SizedBox(height: 16.sp),
                // Add a tex row or inkwell to navigate to the sign up page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDarkMode
                                ? AppColors.neutral600
                                : AppColors.neutral700,
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        // Add navigation logic here
                        // Navigator.pushNamed(context, '/signup');
                        context.go('/login');
                      },
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.sp, horizontal: 3.sp),
                        child: Text(
                          "Log in here ",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: isDarkMode
                                        ? AppColors.neutral50
                                        : AppColors.neutral500,
                                    fontSize: 14.5.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 36.sp),

                TermsAndPrivacyText()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.neutral300,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: Text(
            'or',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.neutral500,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.neutral300,
          ),
        ),
      ],
    );
  }
}
