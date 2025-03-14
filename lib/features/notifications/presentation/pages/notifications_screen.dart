import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement mark all as read
            },
            child: Text(
              'Mark all as read',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.sp),
        itemCount: _mockNotifications.length,
        itemBuilder: (context, index) {
          final notification = _mockNotifications[index];
          return _buildNotificationItem(context, notification, theme, isDark);
        },
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, Map<String, dynamic> notification, ThemeData theme, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: notification['isRead']
            ? (isDark ? AppColors.surfaceDark100 : Colors.white)
            : (isDark ? AppColors.surfaceDark200 : AppColors.primary50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.surfaceDark300 : AppColors.borderLight,
        ),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Handle notification tap
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: _getIconBackgroundColor(notification['type'], isDark),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getNotificationIcon(notification['type']),
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification['title'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      notification['message'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      notification['time'],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.neutral400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getIconBackgroundColor(String type, bool isDark) {
    switch (type) {
      case 'price_drop':
        return AppColors.success;
      case 'new_property':
        return AppColors.primary500;
      case 'investment':
        return AppColors.warning;
      default:
        return AppColors.neutral500;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'price_drop':
        return EneftyIcons.trend_down_outline;
      case 'new_property':
        return EneftyIcons.home_outline;
      case 'investment':
        return EneftyIcons.money_outline;
      default:
        return EneftyIcons.notification_outline;
    }
  }
}

final _mockNotifications = [
  {
    'type': 'price_drop',
    'title': 'Price Drop Alert',
    'message': 'The Urban Oasis price has been reduced by \$50,000',
    'time': '2 hours ago',
    'isRead': false,
  },
  {
    'type': 'new_property',
    'title': 'New Property Match',
    'message': 'A new property matching your search criteria is available',
    'time': '5 hours ago',
    'isRead': true,
  },
  {
    'type': 'investment',
    'title': 'Investment Update',
    'message': 'Your investment in Skyline Towers has generated 8.5% returns',
    'time': '1 day ago',
    'isRead': true,
  },
]; 