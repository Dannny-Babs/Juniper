import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/property_details/data/models/property_details.dart';

class InvestmentMetrics extends StatelessWidget {
  final PropertyDetails property;
  final bool isDark;

  const InvestmentMetrics({
    Key? key,
    required this.property,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '\$${property.price.toString()}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.neutral700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Profitability',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.neutral500,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success50,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            EneftyIcons.arrow_up_outline,
                            size: 14.sp,
                            color: AppColors.success500,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '${property.profitability}%',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.success500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: 0.75, // Assuming 75% progress
                backgroundColor: AppColors.neutral100,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary500),
                minHeight: 4.h,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      EneftyIcons.profile_2user_outline,
                      size: 14.sp,
                      color: AppColors.primary700,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${property.investorCount} ${property.investorCount == 1 ? 'Investor' : 'Investors'}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primary700,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Available',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark100 : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.neutral100,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMetricRow(
                  'Yearly investment return', '${property.yearlyReturn}%'),
              SizedBox(height: 12.h),
              _buildMetricRow(
                  '5 year total return', '${property.fiveYearReturn}%',
                  isPositive: true),
              SizedBox(height: 12.h),
              _buildMetricRow('ROI', '${property.roi}%', isPositive: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value,
      {bool isPositive = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.neutral700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isPositive ? AppColors.success500 : AppColors.neutral900,
          ),
        ),
      ],
    );
  }
}
