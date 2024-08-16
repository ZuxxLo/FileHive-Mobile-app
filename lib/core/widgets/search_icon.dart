import 'package:filehive/core/utils/helper/svg_to_image_provider.dart';
import 'package:flutter/material.dart';

import '../utils/images.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      SvgToImageProvider(
        searchIcon,
      ),
    );
  }
}
