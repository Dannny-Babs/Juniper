import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button.dart';
import '../widgets/login_form.dart';
import '../widgets/socialsignin_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.only(
              left: 24.sp,
              right: 24.sp,
              top: 24.sp,
              bottom: bottom + 24.sp,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/try-auth.png',
                    width: double.infinity,
                    height: 170.sp,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 16.sp),
                Text(
                  'Login',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontFamily: 'HelveticaNeue',
                        color: AppColors.neutral500,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp,
                        letterSpacing: -0.5,
                      ),
                ),
                SizedBox(height: 6.sp),
                Text(
                  'Access your curated properties and investment insights with ease',
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
                LoginForm(formKey: formKey),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/forgot-password'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.sp,
                        vertical: 8.sp,
                      ),
                    ),
                    child: Text(
                      'Forgot password?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.neutral500,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.1,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 12.sp),
                CustomButton(
                  height: 48.sp,
                  text: 'Login',
                  backgroundColor: AppColors.neutral500,
                  textColor: AppColors.neutral100,
                  size: ButtonSize.medium,
                  isLoading: false,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Handle login
                    }
                  },
                ),
                SizedBox(height: 20.sp),
                _buildDivider(context),
                SizedBox(height: 20.sp),
                SocialSignInButton(),
                SizedBox(height: 16.sp),
                // Add a tex row or inkwell to navigate to the sign up page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New to Juniper? ',
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
                        context.push('/register');
                      },
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.sp, horizontal: 2.sp),
                        child: Text(
                          "Create an account",
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
