import 'package:flutter/material.dart';

import '../utils/styles_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.backgroundColor,
      this.textColor,
      this.borderRadius,
      required this.text,
      this.fontSize,
      required this.onPressed,
      this.fixSizeAll});
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final void Function() onPressed;
  final bool? fixSizeAll;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: fixSizeAll == true ? const Size(double.maxFinite, 50) : null,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ??
              BorderRadius.circular(
                12,
              ),
        ),
      ),
      child: Text(
        text,
        style: StylesText.textStyle18.copyWith(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
