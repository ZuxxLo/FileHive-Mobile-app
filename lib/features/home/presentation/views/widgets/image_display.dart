import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDisplay extends StatelessWidget {
  final String imageUrl;

  const ImageDisplay({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
  }
}
