import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<void> prefetchImages(
    BuildContext context, List<String> imageUrls) async {
  await Future.wait(
    imageUrls.map(
      (url) => precacheImage(CachedNetworkImageProvider(url), context),
    ),
  );
}
