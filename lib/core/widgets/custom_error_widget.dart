import 'package:filehive/core/utils/styles_text.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errMessage});
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errMessage,
        style: StylesText.textStyle18,
        textAlign: TextAlign.center,
      ),
    );
  }
}
