import 'package:filehive/core/utils/helper/allowed_extensions.dart';

import 'package:flutter/material.dart';

import 'all_section_tbvb.dart';
import 'others_builder_section_tbvb.dart';

class HomeTabBarViewBody extends StatelessWidget {
  const HomeTabBarViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        // CustomButton(
        //   text: "text",
        //   onPressed: () {
        //     ServiceLocator.getIt<UserBloc>().add(DisconnectUserEvent());
        //     Navigator.of(context).pushNamedAndRemoveUntil(
        //         RouteNames.loginScreen, (Route<dynamic> route) => false);
        //   },
        // ),
        const AllSectionTBVB(),

        for (int index = 0;
            index < AllowedExtensions.categories.keys.length;
            index++)
          OthersBuilderSectionTBVB(index: index)
      ],
    );
  }
}
