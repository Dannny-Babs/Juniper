// lib/features/home/presentation/widgets/location_widget.dart
import 'package:flutter/material.dart';
import 'package:juniper/core/utils/colors.dart';
import 'package:enefty_icons/enefty_icons.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Location',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.neutral400,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Icon(
                  EneftyIcons.location_outline,
                  size: 18,
                  color: AppColors.primary500,
                ),
                const SizedBox(width: 4),
                Text(
                  'Toronto, ON',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isDark ? Colors.white : AppColors.neutral800,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.5,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
        _buildNotificationButton(isDark: isDark),
      ],
    );
  }


  Widget _buildNotificationButton({required bool isDark}) {
    return IconButton(
      padding: const EdgeInsets.all(8),
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: isDark ? AppColors.neutral800 : AppColors.borderLight,
            ),
          ),
        ),
      ),
      icon: const Icon(EneftyIcons.notification_outline, size: 22),
      onPressed: () {},
      color: isDark ? AppColors.neutral300 : AppColors.neutral800,
    );
  }
}

