import 'package:flutter/material.dart';
import '../../../../core/widgets/optimized_image.dart';

class PropertyDetailsGallery extends StatelessWidget {
  final List<String> images;

  const PropertyDetailsGallery({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(); // Return empty container if no images
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: OptimizedImage(
                  imageUrl: images[index],
                  width: 160,
                  height: 120,
                  borderRadius: 12,
                  useShimmer: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
