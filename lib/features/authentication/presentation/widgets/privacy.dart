import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';


class TermsAndPrivacyText extends StatelessWidget {
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;
  
  const TermsAndPrivacyText({
    super.key, 
    this.onTermsTap,
    this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.neutral500,
          fontSize: 12.sp,
          letterSpacing: 0,
        ),
        children: [
          const TextSpan(
            text: 'By signing up, you agree to our ',
            style: TextStyle(
              color: AppColors.gray500,
            ),
          ),
          TextSpan(
            text: 'Terms of Service',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onTermsTap,
          ),
          const TextSpan(
            text: ' and ',
             style: TextStyle(
              color: AppColors.gray500,
            ),
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onPrivacyTap,
          ),
          const TextSpan(
            text: '.',
          ),
        ],
      ),
    );
  }
}