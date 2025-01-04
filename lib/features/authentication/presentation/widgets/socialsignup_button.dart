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
              backgroundColor: Colors.white,
              foregroundColor: AppColors.gray500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.gray300),
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
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
