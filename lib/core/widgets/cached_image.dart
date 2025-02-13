import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum ImageType { asset, network }

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final ImageType type;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.type =
        ImageType.asset, // Default to asset since you're using local images
  });

  static final Widget _defaultErrorWidget = Container(
    color: Colors.grey, // simplified constant color instead of Colors.grey[200]
    child: const Icon(Icons.error_outline),
  );

  static final Widget _defaultPlaceholder = Container(
    color: Colors.grey, // simplified constant color
    child: Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (type == ImageType.asset) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _defaultErrorWidget,
      );
    }

    return RepaintBoundary(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        memCacheWidth: width?.toInt(),
        memCacheHeight: height?.toInt(),
        maxWidthDiskCache: width != null ? width!.toInt() * 2 : 600,
        maxHeightDiskCache: height != null ? height!.toInt() * 2 : 600,
        placeholder: (context, url) => _defaultPlaceholder,
        errorWidget: (context, url, error) => _defaultErrorWidget,
      ),
    );
  }
}
