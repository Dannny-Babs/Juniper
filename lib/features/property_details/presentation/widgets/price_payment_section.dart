import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/property_details/data/models/property_details.dart';
import 'package:intl/intl.dart';

class PricePaymentSection extends StatefulWidget {
  final PropertyDetails property;
  final bool isDark;

  const PricePaymentSection({
    Key? key,
    required this.property,
    required this.isDark,
  }) : super(key: key);

  @override
  State<PricePaymentSection> createState() => _PricePaymentSectionState();
}

class _PricePaymentSectionState extends State<PricePaymentSection> {
  bool _showCalculator = false;
  double _downPayment = 20; // 20% default down payment
  int _loanTerm = 30; // 30 years default

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat("#,##0", "en_US");
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: widget.isDark ? AppColors.surfaceDark100 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: widget.isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price & Payment',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color:
                  widget.isDark ? AppColors.neutral100 : AppColors.neutral900,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${currencyFormatter.format(widget.property.price)}',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: widget.isDark
                      ? AppColors.neutral100
                      : AppColors.neutral900,
                  height: 1,
                ),
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  widget.property.type == 'Rental' ? '/month' : '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.neutral500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildAdditionalCosts(),
          SizedBox(height: 16.h),
          InkWell(
            onTap: () {
              setState(() {
                _showCalculator = !_showCalculator;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: widget.isDark
                    ? AppColors.surfaceDark200
                    : AppColors.neutral50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _showCalculator
                        ? 'Hide Mortgage Calculator'
                        : 'Show Mortgage Calculator',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary500,
                    ),
                  ),
                  Icon(
                    _showCalculator
                        ? EneftyIcons.arrow_up_2_outline
                        : EneftyIcons.arrow_down_outline,
                    size: 18.sp,
                    color: AppColors.primary500,
                  ),
                ],
              ),
            ),
          ),
          if (_showCalculator) ...[
            SizedBox(height: 16.h),
            _buildMortgageCalculator(),
          ],
        ],
      ),
    );
  }

  Widget _buildAdditionalCosts() {
    final List<Map<String, dynamic>> additionalCosts = [
      {'label': 'Utilities', 'cost': '\$250/month'},
      {'label': 'Maintenance', 'cost': '\$100/month'},
      {
        'label': 'Security Deposit',
        'cost': '\$${(widget.property.price * 0.5).toInt()}'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: additionalCosts
          .map((item) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['label'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: widget.isDark
                            ? AppColors.neutral300
                            : AppColors.neutral700,
                      ),
                    ),
                    Text(
                      item['cost'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: widget.isDark
                            ? AppColors.neutral100
                            : AppColors.neutral900,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildMortgageCalculator() {
    final price = widget.property.price;
    final downPaymentAmount = (price * _downPayment / 100);
    final loanAmount = price - downPaymentAmount;
    final interestRate = 5.5; // Example fixed interest rate

    // Monthly payment calculation (simplified)
    final monthlyInterest = interestRate / 100 / 12;
    final totalPayments = _loanTerm * 12;
    final monthlyPayment = loanAmount *
        (monthlyInterest * pow(1 + monthlyInterest, totalPayments)) /
        (pow(1 + monthlyInterest, totalPayments) - 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mortgage Calculator',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: widget.isDark ? AppColors.neutral100 : AppColors.neutral900,
          ),
        ),
        SizedBox(height: 16.h),
        _buildSlider(
          label: 'Down Payment: ${_downPayment.toInt()}%',
          value: _downPayment,
          min: 5,
          max: 50,
          onChanged: (value) {
            setState(() {
              _downPayment = value;
            });
          },
        ),
        _buildSlider(
          label: 'Loan Term: $_loanTerm years',
          value: _loanTerm.toDouble(),
          min: 10,
          max: 30,
          divisions: 4,
          onChanged: (value) {
            setState(() {
              _loanTerm = value.toInt();
            });
          },
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color:
                widget.isDark ? AppColors.surfaceDark200 : AppColors.primary50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              _buildMortgageDetail('Loan Amount',
                  '\$${NumberFormat("#,##0", "en_US").format(loanAmount.toInt())}'),
              SizedBox(height: 8.h),
              _buildMortgageDetail(
                  'Interest Rate', '${interestRate.toString()}%'),
              SizedBox(height: 8.h),
              _buildMortgageDetail('Monthly Payment',
                  '\$${NumberFormat("#,##0", "en_US").format(monthlyPayment.toInt())}'),
              SizedBox(height: 8.h),
              _buildMortgageDetail('Loan Term', '$_loanTerm years'),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '*This is an estimate. Actual payment may vary based on credit score, taxes and insurance.',
          style: TextStyle(
            fontSize: 12.sp,
            fontStyle: FontStyle.italic,
            color: AppColors.neutral500,
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(
      {required String label,
      required double value,
      required double min,
      required double max,
      int? divisions,
      required ValueChanged<double> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: widget.isDark ? AppColors.neutral300 : AppColors.neutral700,
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4.h,
            thumbColor: AppColors.primary500,
            activeTrackColor: AppColors.primary500,
            inactiveTrackColor:
                widget.isDark ? AppColors.surfaceDark300 : AppColors.neutral100,
            overlayColor: AppColors.primary500.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildMortgageDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: widget.isDark ? AppColors.neutral300 : AppColors.neutral700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: widget.isDark ? AppColors.neutral100 : AppColors.neutral900,
          ),
        ),
      ],
    );
  }
}

// Helper function
double pow(double x, int exponent) {
  double result = 1.0;
  for (int i = 0; i < exponent; i++) {
    result *= x;
  }
  return result;
}
