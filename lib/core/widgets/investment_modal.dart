import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/button.dart';

import 'investment_confirmation_modal.dart';

class InvestmentModal extends StatefulWidget {
  final double balance;
  final VoidCallback? onClose;
  final Function(double amount, PaymentMethod method)? onInvest;
  final String propertyTitle;

  const InvestmentModal({
    Key? key,
    required this.balance,
    this.onClose,
    this.onInvest,
    required this.propertyTitle,
  }) : super(key: key);

  static void show(
    BuildContext context, {
    required double balance,
    required String propertyTitle,
    Function(double amount, PaymentMethod method)? onInvest,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InvestmentModal(
        balance: balance,
        propertyTitle: propertyTitle,
        onClose: () => Navigator.pop(context),
        onInvest: onInvest,
      ),
    );
  }

  @override
  State<InvestmentModal> createState() => _InvestmentModalState();
}

class _InvestmentModalState extends State<InvestmentModal> {
  double _selectedAmount = 0;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.wallet;
  final List<double> _presetAmounts = [250, 500, 1000, 1500, 2000];

  bool get _canInvest =>
      _selectedAmount > 0 && _selectedAmount <= widget.balance;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 1,
      decoration: BoxDecoration(
        color: Colors.black54,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildCloseButton(),
          Container(
            // Changed from Flexible for better layout
            margin: EdgeInsets.all(8.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark100 : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(24.r),
              ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildHeader(isDark)),
                SizedBox(height: 32.h),
                _buildAmountSection(isDark),
                SizedBox(height: 20.h),
                _buildBalanceSection(isDark),
                SizedBox(height: 32.h),
                _buildPaymentMethodsSection(isDark),
                SizedBox(height: 48.h),
                _buildCTAButton(isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Center(
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.neutral50,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: AppColors.neutral700,
              size: 20.sp,
            ),
            onPressed: widget.onClose,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Amount',
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.neutral500,
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1),
        Text(
          widget.propertyTitle,
          style: textTheme.titleLarge?.copyWith(
            color: isDark ? AppColors.neutral100 : AppColors.neutral700,
            fontWeight: FontWeight.w500,
            fontSize: 22.sp,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildAmountSection(bool isDark) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Custom styled amount display
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Currency symbol - smaller and raised
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                '\$',
                style: textTheme.titleMedium?.copyWith(
                    color: isDark ? AppColors.neutral300 : AppColors.neutral600,
                    height: 1,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(width: 4.w),
            // Main amount number - larger and bolder
            Text(
              _selectedAmount > 0 ? _selectedAmount.toStringAsFixed(0) : '0',
              style: textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.neutral100 : AppColors.neutral800,
                fontSize: 36.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _presetAmounts.map((amount) {
              final isSelected = _selectedAmount == amount;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAmount = amount;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary500
                          : isDark
                              ? AppColors.surfaceDark300
                              : AppColors.neutral100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '\$${amount.toInt()}',
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                        fontSize: 14.sp,
                        color: isSelected
                            ? Colors.white
                            : isDark
                                ? AppColors.neutral300
                                : AppColors.neutral700,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceSection(bool isDark) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Balance',
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.neutral500,
          ),
        ),
        Text(
          '\$${widget.balance.toStringAsFixed(2)}',
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.neutral100 : AppColors.neutral800,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodsSection(bool isDark) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: textTheme.titleSmall?.copyWith(
            color: isDark ? AppColors.neutral100 : AppColors.neutral800,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 16.h),
        _buildPaymentOption(
          PaymentMethod.wallet,
          'Wallet - Default',
          EneftyIcons.wallet_outline,
          isDark,
        ),
        SizedBox(height: 12.h),
        _buildPaymentOption(
          PaymentMethod.creditCard,
          'MasterCard •••• 3462',
          EneftyIcons.card_outline,
          isDark,
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
      PaymentMethod method, String title, IconData icon, bool isDark) {
    final textTheme = Theme.of(context).textTheme;
    final isSelected = _selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark200 : AppColors.neutral50,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: AppColors.primary500,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.neutral100 : AppColors.neutral900,
                ),
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary500
                      : isDark
                          ? AppColors.surfaceDark300
                          : AppColors.neutral300,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary500 : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14.sp,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTAButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: CustomButton(
        text: 'Invest Property',
        variant: ButtonVariant.primary,
        backgroundColor: AppColors.neutral800,
        textColor: Colors.white,
        isDisabled: !_canInvest,
        onPressed: _canInvest
            ? () {
                // Close the current modal
                Navigator.of(context).pop();

                // Simulate a network request with 50% success rate for demo purposes
                final bool isSuccess =
                    DateTime.now().millisecondsSinceEpoch % 2 == 0;

                // Show confirmation modal
                InvestmentConfirmationModal.show(
                  context,
                  state: isSuccess
                      ? ConfirmationState.success
                      : ConfirmationState.error,
                  amount: _selectedAmount,
                  propertyTitle: widget.propertyTitle,
                  errorMessage: isSuccess
                      ? null
                      : "Payment method declined. Please try a different payment method.",
                  onPrimaryAction: () {
                    // On success: Go to home or portfolio
                    // On error: Retry

                    if (isSuccess) {
                      // Navigate to home/portfolio
                      context.go('/portfolio');
                    } else {
                      // Show investment modal again
                      InvestmentModal.show(
                        context,
                        balance: widget.balance,
                        propertyTitle: widget.propertyTitle,
                        onInvest: widget.onInvest,
                      );
                    }
                  },
                  onSecondaryAction: () {
                    // Only used in error state for "Cancel"
                    Navigator.pop(context);
                  },
                );

                // Still call the original onInvest callback if needed
                if (isSuccess && widget.onInvest != null) {
                  widget.onInvest!(_selectedAmount, _selectedPaymentMethod);
                }
              }
            : null,
      ),
    );
  }
}

enum PaymentMethod { wallet, creditCard }
