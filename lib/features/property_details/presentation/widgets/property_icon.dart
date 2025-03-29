import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class PropertyIcon extends StatelessWidget {
  final String iconPath;
  final double? size;
  final Color? color;

  const PropertyIcon({
    super.key,
    required this.iconPath,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return SvgPicture.asset(
      'assets/icons/$iconPath',
      width: size ?? 24.sp,
      height: size ?? 24.sp,
      colorFilter: ColorFilter.mode(
        color ?? (isDark ? AppColors.neutral100 : AppColors.neutral900),
        BlendMode.srcIn,
      ),
    );
  }
} 