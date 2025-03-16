import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageErrorHandler {
  /// Default placeholder image URL to use when the original URL fails
  static const String defaultPlaceholderUrl = 
      'https://via.placeholder.com/300x200?text=Image+Not+Available';
  
  /// Fallback placeholder URLs for different categories
  static const Map<String, String> categoryPlaceholders = {
    'property': 'https://via.placeholder.com/300x200?text=Property+Image',
    'profile': 'https://via.placeholder.com/300x300?text=Profile',
    'landscape': 'https://via.placeholder.com/400x200?text=Landscape',
  };

  /// Safely loads an image with fallback options
  static Widget loadImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    String category = 'property',
    Widget? customErrorWidget,
    Widget? customLoadingWidget,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => customLoadingWidget ?? 
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        debugPrint('Image error: $url - $error');
        return customErrorWidget ?? Image.network(
          categoryPlaceholders[category] ?? defaultPlaceholderUrl,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 40),
              ),
            );
          },
        );
      },
    );
  }
}
