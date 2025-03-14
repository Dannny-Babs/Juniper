import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/optimized_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PropertyImageCarousel extends StatefulWidget {
  final List<String> images;
  final double? height;

  const PropertyImageCarousel({
    Key? key,
    required this.images,
    this.height = 240,
  }) : super(key: key);

  @override
  State<PropertyImageCarousel> createState() => _PropertyImageCarouselState();
}

class _PropertyImageCarouselState extends State<PropertyImageCarousel> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height?.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return OptimizedImage(
                imageUrl: widget.images[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            bottom: 16.h,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.images.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 4.h,
                  dotWidth: 4.w,
                  spacing: 4.w,
                  expansionFactor: 3,
                  activeDotColor: AppColors.primary500,
                  dotColor: Colors.white.withAlpha(128),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
