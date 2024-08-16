import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';
import '../../../../../../core/utils/styles_text.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print("ForgotPasswordSectionForgotPasswordSection buildbuildbuildbuild") ;
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Forgot your password?',
                style: StylesText.textStyle14.copyWith(
                  color: kPrimaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //not implemented in the current api version.
                  }),
          ],
        ),
      ),
    );
  }
}
