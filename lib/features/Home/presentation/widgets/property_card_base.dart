import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../data/models/property.dart';
import 'package:juniper/core/widgets/optimized_image.dart';

abstract class PropertyCardBase extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;
  final bool isCompact;

  const PropertyCardBase({
    super.key,
    required this.property,
    this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final containerDecoration = BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: isDark ? AppColors.surfaceDark300 : AppColors.borderLight,
      ),
    );

    return Container(
      width: isCompact ? 240.w : double.infinity,
      padding: EdgeInsets.all(6.w),
      decoration: containerDecoration,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: buildContent(context, theme, isDark),
      ),
    );
  }

  Widget buildContent(BuildContext context, ThemeData theme, bool isDark);

  Widget buildImage(BuildContext context, double height) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PropertyImageWidget(
      imageUrl: property.imageUrl,
      height: height,
      isDark: isDark,
    );
  }

  Widget buildPrice(ThemeData theme) {
    return Text(
      property.price,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
        color: AppColors.primary600,
      ),
    );
  }
}

class PropertyImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final bool isDark;

  const PropertyImageWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return OptimizedImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: height,
      borderRadius: 6.r,
      useShimmer: true,
    );
  }
}
