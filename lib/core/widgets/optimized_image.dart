import 'package:flutter/material.dart';
import '../utils/utils.dart';

class OptimizedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;
  final bool useShimmer;

  const OptimizedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.useShimmer = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final radius = borderRadius?.r ?? 8.r;

    // Calculate cache dimensions, ensuring they're valid integers
    final cacheWidth = width != null && width!.isFinite ? width!.toInt() : null;
    final cacheHeight =
        height != null && height!.isFinite ? height!.toInt() : null;

    Widget fallbackWidget = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(
        EneftyIcons.buildings_2_outline,
        size: (width ?? 40).clamp(24.0, 120.0),
        color: theme.colorScheme.onSurface.withAlpha((0.4 * 255).round()),
      ),
    );

    Widget buildShimmer() {
      return Shimmer.fromColors(
        baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );
    }

    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      maxWidthDiskCache: cacheWidth != null ? cacheWidth * 2 : 600,
      maxHeightDiskCache: cacheHeight != null ? cacheHeight * 2 : 600,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => useShimmer
          ? buildShimmer()
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
      errorWidget: (context, url, error) {
        debugPrint('Image error for $url: $error');
        return fallbackWidget;
      },
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: image,
      );
    }

    return image;
  }
}
