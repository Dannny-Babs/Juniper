import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../data/models/property.dart';

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

    return Container(
      width: isCompact ? 240.w : double.infinity,
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.surfaceDark300 : AppColors.borderLight,
        ),
      ),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildShimmer(),
          errorWidget: (context, url, error) => _buildErrorWidget(context),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
        size: 40,
      ),
    );
  }
}
