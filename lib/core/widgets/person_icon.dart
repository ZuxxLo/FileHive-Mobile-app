import 'package:filehive/core/utils/images.dart';
import 'package:flutter/material.dart';

import '../utils/helper/svg_to_image_provider.dart';

class PersonIcon extends StatelessWidget {
  const PersonIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(SvgToImageProvider(
      personIcon,
    ));
  }
}
