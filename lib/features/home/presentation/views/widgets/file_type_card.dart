import 'package:filehive/core/utils/styles_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileTypeCard extends StatelessWidget {
  final String iconPath;
  final String? title;

  const FileTypeCard({
    required this.iconPath,
    required this.title,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: SvgPicture.asset(
            iconPath,
            width: 80,
          ),
        ),
        title != null
            ? Flexible(
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: StylesText.textStyle14
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 8),
      ],
    );
  }
}
