import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      placeholder: placeholder ??
          (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
      errorWidget:
          errorWidget ?? (context, url, error) => const Icon(Icons.error),
    );
  }
}
