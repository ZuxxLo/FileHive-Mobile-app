import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/images.dart';

class FilehiveLogo extends StatelessWidget {
  const FilehiveLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      logoImage,
    );
  }
}
