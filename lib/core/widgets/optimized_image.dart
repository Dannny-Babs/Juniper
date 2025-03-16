import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';

class OptimizedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;
  final bool useShimmer;
  final String fallbackAssetImage;

  const OptimizedImage({
    super.key,
    required this.imageUrl,
    required this.width,
    this.height,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.useShimmer = false,
    this.fallbackAssetImage = 'assets/images/placeholder.png',
  });

  @override
  Widget build(BuildContext context) {
    final fallbackImages = [
      'assets/images/properties/property1.jpg',
      'assets/images/properties/property2.jpg',
      'assets/images/properties/property3.jpg',
      'assets/images/properties/property4.jpg',
    ];

    // Safely handle hash calculation
    final fallbackIndex = imageUrl.isNotEmpty
        ? imageUrl.hashCode.abs() % fallbackImages.length
        : 0;

    final actualFallbackImage =
        fallbackAssetImage == 'assets/images/placeholder.png'
            ? fallbackImages[fallbackIndex]
            : fallbackAssetImage;

    // If URL is empty or invalid (doesn't start with http), use fallback
    if (imageUrl.isEmpty || !imageUrl.startsWith('http')) {
      return _buildAssetFallback(actualFallbackImage);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 200),
        // Don't use memCacheWidth as it can cause issues on some devices
        errorWidget: (context, url, error) {
          debugPrint('Image error: $url - $error');
          return _buildAssetFallback(actualFallbackImage);
        },
        placeholder: (context, url) {
          return useShimmer
              ? _buildShimmerEffect()
              : _buildAssetFallback(actualFallbackImage);
        },
        // Set a short cache duration for development
        cacheManager: _CustomCacheManager(),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Widget _buildAssetFallback(String assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        assetPath,
        width: width,
        height: height ?? width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Asset image error: $assetPath - $error');
          return Container(
            width: width,
            height: height ?? width,
            color: Colors.grey[300],
            child: const Icon(Icons.image, color: Colors.grey),
          );
        },
      ),
    );
  }
}
// Basic custom cache manager to handle short cache durations during development
class _CustomCacheManager extends CacheManager {
  static const key = 'optimizedImageCache';

  static final _instance = _CustomCacheManager._();

  factory _CustomCacheManager() => _instance;

  _CustomCacheManager._()
      : super(Config(
          key,
          stalePeriod: const Duration(days: 1),
          maxNrOfCacheObjects: 100,
          fileService: HttpFileService(),
        ));
}
