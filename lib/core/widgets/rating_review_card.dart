import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class RatingReviewCard extends StatelessWidget {
  final double overallRating;
  final Map<String, double> subRatings;
  final int totalReviews;

  const RatingReviewCard({
    Key? key,
    required this.overallRating,
    required this.subRatings,
    required this.totalReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark100 : AppColors.primary50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.neutral100,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ratings and Reviews',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: isDark ? AppColors.neutral100 : AppColors.neutral900,
                ),
              ),
              Text(
                '$totalReviews reviews',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.neutral500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                overallRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.neutral100 : AppColors.primary800,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: overallRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.w,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.warning,
                    ),
                    onRatingUpdate: (_) {},
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Based on $totalReviews reviews',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.primary700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          ...subRatings.entries.map((entry) => _buildSubRating(
                context,
                entry.key,
                entry.value,
                isDark,
              )),
        ],
      ),
    );
  }

  Widget _buildSubRating(
      BuildContext context, String title, double value, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.neutral300 : AppColors.neutral700,
                ),
              ),
              Text(
                value.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: isDark ? AppColors.neutral100 : AppColors.primary700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: value / 5,
              backgroundColor:
                  isDark ? AppColors.primary300 : AppColors.primary200,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary500),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }
}
