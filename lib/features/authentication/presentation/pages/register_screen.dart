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
                        color: AppColors.neutral500,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.5.sp,
                        letterSpacing: -0.5,
                      ),
                ),
                SizedBox(height: 6.sp),
                Text(
                  'Sign up to find your dream apartment or manage your property investments effortlessly.',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'HelveticaNeue',
                        color: AppColors.gray500,
                        fontWeight: FontWeight.normal,
                        height: 1.3,
                        fontSize: 14.sp,
                        letterSpacing: -0.1,
                      ),
                ),
                SizedBox(height: 32.sp),
                RegisterForm(formKey: formKey),
                const SizedBox(height: 16),
                CustomButton(
                  height: 48.sp,
                  text: 'Create Account',
                  backgroundColor: AppColors.neutral500,
                  textColor: AppColors.neutral100,
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
                            color: const Color.fromARGB(163, 80, 80, 101),
                            fontSize: 14.sp,
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
                            vertical: 4.sp, horizontal: 2.sp),
                        child: Text(
                          "Log in here ",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.neutral500,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.sp),

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
            color: AppColors.gray300,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: Text(
            'or',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray500,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.gray300,
          ),
        ),
      ],
    );
  }
}
