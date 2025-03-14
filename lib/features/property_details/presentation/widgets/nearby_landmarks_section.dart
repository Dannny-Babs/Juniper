import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class NearbyLandmarksSection extends StatelessWidget {
  final List<NearbyLandmark> landmarks;
  final bool isDark;

  const NearbyLandmarksSection({
    Key? key,
    required this.landmarks,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Group landmarks by category
    final Map<String, List<NearbyLandmark>> groupedLandmarks = {};
    for (var landmark in landmarks) {
      if (!groupedLandmarks.containsKey(landmark.category)) {
        groupedLandmarks[landmark.category] = [];
      }
      groupedLandmarks[landmark.category]!.add(landmark);
    }

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
            'Nearby Landmarks',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.neutral100 : AppColors.neutral900,
            ),
          ),
          SizedBox(height: 16.h),
          ...groupedLandmarks.entries
              .map((entry) => _buildCategorySection(entry.key, entry.value))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
      String category, List<NearbyLandmark> landmarks) {
    IconData icon;
    Color color;

    switch (category.toLowerCase()) {
      case 'transport':
        icon = EneftyIcons.bus_outline;
        color = AppColors.primary500;
        break;
      case 'education':
        icon = EneftyIcons.book_outline;
        color = AppColors.info;
        break;
      case 'shopping':
        icon = EneftyIcons.shopping_bag_outline;
        color = AppColors.success500;
        break;
      case 'recreation':
        icon = EneftyIcons.tree_outline;
        color = AppColors.warning;
        break;
      default:
        icon = EneftyIcons.location_outline;
        color = AppColors.neutral500;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: color,
            ),
            SizedBox(width: 8.w),
            Text(
              category,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.neutral100 : AppColors.neutral900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...landmarks.map((landmark) => _buildLandmarkItem(landmark)).toList(),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildLandmarkItem(NearbyLandmark landmark) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              landmark.name,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? AppColors.neutral300 : AppColors.neutral700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark200 : AppColors.neutral50,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              _formatDistance(landmark.distance),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.neutral200 : AppColors.neutral700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDistance(double distanceInKm) {
    if (distanceInKm < 1) {
      final meters = (distanceInKm * 1000).round();
      return '$meters m';
    } else {
      return '${distanceInKm.toStringAsFixed(1)} km';
    }
  }
}

class NearbyLandmark {
  final String name;
  final String category; // Transport, Education, Shopping, Recreation
  final double distance; // in kilometers

  NearbyLandmark({
    required this.name,
    required this.category,
    required this.distance,
  });
}
