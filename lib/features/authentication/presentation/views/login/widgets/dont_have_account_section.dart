import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';

import '../../../../../../core/utils/router/routes_names.dart';
import '../../../../../../core/utils/styles_text.dart';

class DontHaveAccountSection extends StatelessWidget {
  const DontHaveAccountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account?",
            style: StylesText.textStyle14.copyWith(color: Colors.white),
          ),
          TextSpan(
              text: ' create one !',
              style: StylesText.textStyle14.copyWith(
                color: kPrimaryColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteNames.signupScreen); // value: BlocProvider.of<AuthBloc>(context),
                }),
        ],
      ),
    );
  }
}
