import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/button.dart';

enum ConfirmationState {
  success,
  error,
}

class InvestmentConfirmationModal extends StatelessWidget {
  final ConfirmationState state;
  final VoidCallback? onClose;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final double amount;
  final String propertyTitle;
  final String? errorMessage;

  const InvestmentConfirmationModal({
    super.key,
    required this.state,
    this.onClose,
    this.onPrimaryAction,
    this.onSecondaryAction,
    required this.amount,
    required this.propertyTitle,
    this.errorMessage,
  });

  static void show(
    BuildContext context, {
    required ConfirmationState state,
    required double amount,
    required String propertyTitle,
    String? errorMessage,
    VoidCallback? onPrimaryAction,
    VoidCallback? onSecondaryAction,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
      builder: (context) => InvestmentConfirmationModal(
        state: state,
        amount: amount,
        propertyTitle: propertyTitle,
        errorMessage: errorMessage,
        onClose: () => Navigator.pop(context),
        onPrimaryAction: onPrimaryAction ??
            () {
              Navigator.pop(context);
            },
        onSecondaryAction: onSecondaryAction ??
            () {
              Navigator.pop(context);
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCloseButton(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            constraints: BoxConstraints(
              maxWidth: 380.w,
            ),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark100 : Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                state == ConfirmationState.success
                    ? _buildSuccessContent(context)
                    : _buildErrorContent(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: AppColors.neutral100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            size: 16.sp,
            color: AppColors.neutral700,
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Success Icon
        SizedBox(
          width: 100.w,
          height: 100.w,
          child: Lottie.asset(
            'assets/animations/transaction_success.json',
            fit: BoxFit.contain,
            repeat: false, // Don't repeat animation
            animate: true,
          ),
        ),
        SizedBox(height: 24.h),

        // Success Title and Message
        Text(
          "Congratulations!",
          textAlign: TextAlign.center,
          style: textTheme.titleLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.neutral100 : AppColors.neutral700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Your investment journey continues!",
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: AppColors.neutral500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Check for detailed performance insights.",
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: AppColors.neutral500,
          ),
        ),
        SizedBox(height: 16.h),

        // Investment Details
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark200 : AppColors.neutral50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                context,
                "Property",
                propertyTitle,
              ),
              SizedBox(height: 12.h),
              _buildDetailRow(
                context,
                "Amount",
                "\$${amount.toStringAsFixed(2)}",
                valueColor: AppColors.success500,
              ),
              SizedBox(height: 12.h),
              _buildDetailRow(
                context,
                "Investment Fee",
                "\$${(amount * 0.02).toStringAsFixed(2)}",
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // Transaction Status Message
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark200 : AppColors.neutral50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.neutral200,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 16.sp,
                color: AppColors.neutral600,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  "Your investment transaction will be completed in approximately 4 days.",
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.neutral600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.h),

        // Primary Action Button
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: CustomButton(
            text: "Go to Home",
            variant: ButtonVariant.primary,
            backgroundColor: AppColors.neutral800,
            onPressed: onPrimaryAction,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorContent(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Error Icon
        SizedBox(
          width: 100.w,
          height: 100.w,
          child: Lottie.asset(
            'assets/animations/transaction_failed.json',
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 24.h),

        // Error Title and Message
        Text(
          "Investment Failed",
          textAlign: TextAlign.center,
          style: textTheme.titleLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.neutral100 : AppColors.neutral700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Something went wrong. Please try again later.",
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: AppColors.neutral500,
          ),
        ),
        SizedBox(height: 16.h),

        // Error Details (Optional)
        if (errorMessage != null) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark200 : Color(0xFFFFEDED),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? AppColors.borderDark : Color(0xFFFFCCCC),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 16.sp,
                  color: AppColors.error,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    errorMessage!,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],

        // Retry & Cancel Buttons
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: CustomButton(
                  noShadow: true,
                  text: "Cancel",
                  variant: ButtonVariant.outline,
                  backgroundColor: AppColors.neutral50,
                  onPressed: onSecondaryAction,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: CustomButton(
                  text: "Retry",
                  variant: ButtonVariant.primary,
                  backgroundColor: AppColors.neutral800,
                  onPressed: onPrimaryAction,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {Color? valueColor}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: AppColors.neutral600,
          ),
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: valueColor ??
                (isDark ? AppColors.neutral100 : AppColors.neutral600),
          ),
        ),
      ],
    );
  }
}
