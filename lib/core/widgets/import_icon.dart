import 'package:filehive/core/utils/helper/svg_to_image_provider.dart';
import 'package:filehive/core/utils/images.dart';
import 'package:flutter/material.dart';

class ImportIcon extends StatelessWidget {
  final Color? color;
  const ImportIcon({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(SvgToImageProvider(importIcon), color: color);
  }
}
