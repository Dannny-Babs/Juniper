import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: isDark ? AppColors.surfaceDark100 : AppColors.borderLight,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Location section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Location',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral400,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.sp,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        EneftyIcons.location_outline,
                        size: 18.sp,
                        color: AppColors.primary500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Toronto, ON',
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: isDark ? Colors.white : AppColors.neutral800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.5.sp,
                            letterSpacing: 0),
                      ),
                    ],
                  ),
                ],
              ),

              // Notification button
              Center(
                child: IconButton(
                  padding: EdgeInsets.all(8),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(
                          color: isDark
                              ? AppColors.neutral800
                              : AppColors.borderLight,
                        ),
                      ),
                    ),
                  ),
                  icon: const Icon(EneftyIcons.notification_outline, size: 22),
                  onPressed: () {},
                  color: isDark ? AppColors.neutral300 : AppColors.neutral800,
                ),
              ),
            ],
          ),
          SizedBox(height: 32.sp),
          Text(
            'Hi, George!',
            style: theme.textTheme.titleLarge?.copyWith(
                color: isDark ? AppColors.neutral200 : AppColors.neutral500,
                fontWeight: FontWeight.normal,
                fontSize: 18.5.sp),
          ),
          const SizedBox(height: 8),
          Text(
            'Ready to find your next\ninvestment?',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textPrimaryDark : AppColors.neutral900,
              fontSize: 26.sp,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Filter row
          Row(
            children: [
              Expanded(
                // Search Bar

                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        EneftyIcons.search_normal_outline,
                        color: isDark
                            ? AppColors.neutral300
                            : AppColors.neutral700,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        // Add this
                        child: Text(
                          'Search apartments, condos, etc.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                            color: isDark
                                ? AppColors.neutral400
                                : AppColors.neutral600,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Add this to handle text overflow
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: Icon(
                  EneftyIcons.setting_4_outline,
                  color: theme.colorScheme.onSurface.withAlpha(179),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
