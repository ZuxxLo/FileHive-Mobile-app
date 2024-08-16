import 'package:filehive/core/utils/helper/svg_to_image_provider.dart';
import 'package:flutter/material.dart';

import '../utils/images.dart';

class EmailIcon extends StatelessWidget {
  const EmailIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      SvgToImageProvider(
        emailIcon,
      ),
    );
  }
}

class PasswordIcon extends StatelessWidget {
  const PasswordIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(SvgToImageProvider(
      passwordIcon,
    ));
  }
}
