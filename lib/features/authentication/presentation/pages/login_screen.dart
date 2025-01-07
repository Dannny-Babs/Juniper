

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: const Text('Welcome to the Login Page'),
      ),
    );
  }
=======
    final formKey = GlobalKey<FormState>();
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
                  isDarkMode
                      ? 'assets/images/try-auth-dark.png'
                      : 'assets/images/try-auth.png',
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
                'Access your curated properties and investment insights with ease',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.normal,
                      height: 1.3,
                      fontSize: 16.sp,
                      letterSpacing: -0.1,
                      color: isDarkMode
                          ? AppColors.neutral200
                          : AppColors.neutral800,
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
                          color: isDarkMode
                              ? AppColors.neutral50
                              : AppColors.neutral600,
                          fontSize: 14.sp,
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
                backgroundColor: isDarkMode
                    ? AppColors.backgroundLight
                    : AppColors.neutral800,
                textColor: isDarkMode
                    ? AppColors.neutral900
                    : AppColors.backgroundLight,
                size: ButtonSize.medium,
                isLoading: false,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Handle login
                    context.push('/home');
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
                          color: isDarkMode
                              ? AppColors.neutral50
                              : AppColors.neutral600,
                          fontSize: 14.5.sp,
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDarkMode
                                  ? AppColors.neutral600
                                  : AppColors.neutral700,
                              fontSize: 14.5.sp,
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
>>>>>>> Stashed changes
}
