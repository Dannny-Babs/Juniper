import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class SocialSignUpButton extends StatelessWidget {
  const SocialSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52.sp,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.surfaceDark100
                  : AppColors.neutral100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.surfaceDark400
                      : AppColors.neutral200,
                ),
              ),
            ),
            onPressed: () {
              // Handle Google sign in
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google.png',
                  width: 24.sp,
                  height: 24.sp,
                ),
                SizedBox(width: 8),
                Text(
                  'Sign up with Google',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.neutral50
                          : AppColors.neutral900,
                      fontSize: 15.6.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
