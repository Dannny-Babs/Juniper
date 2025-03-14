import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/property_details/data/models/property_details.dart';
import 'package:juniper/features/property_details/presentation/widgets/property_icon.dart';

class PropertyFeatures extends StatelessWidget {
  final PropertyDetails property;

  const PropertyFeatures({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark100 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.neutral100,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildFeatureItem(
                  context,
                  'bed.svg',
                  property.beds.toString(),
                  'Bed rooms',
                ),
              ),
              Container(
                height: 40.h,
                width: 1,
                color: isDark ? AppColors.borderDark : AppColors.neutral100,
              ),
              Expanded(
                child: _buildFeatureItem(
                  context,
                  'bath.svg',
                  property.baths.toString(),
                  'Bath rooms',
                ),
              ),
              Container(
                height: 40.h,
                width: 1,
                color: isDark ? AppColors.borderDark : AppColors.neutral100,
              ),
              Expanded(
                child: _buildFeatureItem(
                  context,
                  'sqft.svg',
                  property.sqft.toString(),
                  'sq ft',
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              color: isDark ? AppColors.borderDark : AppColors.neutral100,
              height: 40.h,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildFeatureItem(
                    context, 'shopping.svg', '', 'Shopping center'),
              ),
              Container(
                height: 40.h,
                width: 1,
                color: isDark ? AppColors.borderDark : AppColors.neutral100,
              ),
              Expanded(
                child:
                    _buildFeatureItem(context, 'pool.svg', '', 'Private pool'),
              ),
              Container(
                height: 40.h,
                width: 1,
                color: isDark ? AppColors.borderDark : AppColors.neutral100,
              ),
              Expanded(
                child: _buildFeatureItem(
                    context, 'fitness.svg', '', 'Fitness Center'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
      BuildContext context, String iconPath, String value, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PropertyIcon(
          iconPath: iconPath,
          size: 24.sp,
          color: AppColors.primary500,
        ),
        if (value.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.neutral100 : AppColors.neutral900,
            ),
          ),
        ],
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isDark ? AppColors.neutral400 : AppColors.neutral500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
