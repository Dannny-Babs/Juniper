import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class InspectionTime {
  final DateTime date;
  final String timeSlot;

  InspectionTime({
    required this.date,
    required this.timeSlot,
  });
}

class InspectionTimesCard extends StatelessWidget {
  final String agentName;
  final String agentImageUrl;
  final List<InspectionTime> inspectionTimes;
  final VoidCallback? onRegisterPressed;

  const InspectionTimesCard({
    super.key,
    required this.agentName,
    required this.agentImageUrl,
    required this.inspectionTimes,
    this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark100 : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inspection Times',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.neutral100 : AppColors.neutral900,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? AppColors.surfaceDark300
                        : AppColors.neutral100,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    agentImageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.person,
                          size: 24.sp,
                          color: isDark
                              ? AppColors.neutral400
                              : AppColors.neutral300,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'With $agentName',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.neutral100
                            : AppColors.neutral900,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Private inspection available',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...inspectionTimes
              .map((time) => _buildTimeSlot(context, time, isDark)),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: onRegisterPressed,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.neutral100,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Register for an Inspection',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(
      BuildContext context, InspectionTime time, bool isDark) {
    final theme = Theme.of(context);
    final dateFormat =
        '${_getDayName(time.date)} ${time.date.day} ${_getMonthName(time.date.month)}';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark200 : AppColors.neutral50,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            EneftyIcons.calendar_outline,
            size: 18.sp,
            color: AppColors.primary500,
          ),
          SizedBox(width: 8.w),
          Text(
            dateFormat,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.neutral100 : AppColors.neutral900,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            time.timeSlot,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: AppColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
