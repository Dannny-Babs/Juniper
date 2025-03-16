import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/button.dart';

class PropertyActionButtons extends StatelessWidget {
  final VoidCallback? onInvestPressed;
  final VoidCallback? onContactPressed;

  const PropertyActionButtons({
    Key? key,
    this.onInvestPressed,
    this.onContactPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 44.h,
            child: CustomButton(
              backgroundColor: AppColors.backgroundLight,
              noShadow: true,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              text: 'View Property', // Changed from "Rent property"
              variant: ButtonVariant.outline,
              size: ButtonSize.medium,
              onPressed: onInvestPressed,
              textColor: AppColors.textSecondaryLight,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SizedBox(
            height: 44.h,
            child: CustomButton(
              noShadow: true,
              text: 'Start Investing',
              variant: ButtonVariant.primary,
              size: ButtonSize.medium,
              backgroundColor: AppColors.neutral800,
              onPressed: onContactPressed,
            ),
          ),
        ),
      ],
    );
  }
}
