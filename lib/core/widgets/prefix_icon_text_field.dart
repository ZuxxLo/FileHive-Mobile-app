import 'package:flutter/material.dart';

class PrefixIconTextField extends StatelessWidget {
  const PrefixIconTextField({
    super.key,
    required this.iconWidget,
  });

  final Widget iconWidget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: SizedBox(
        height: 30,
        child: iconWidget,
      ),
    );
  }
}
