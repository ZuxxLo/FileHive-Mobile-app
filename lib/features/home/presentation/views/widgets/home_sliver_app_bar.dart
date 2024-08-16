import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/helper/allowed_extensions.dart';

import 'package:flutter/material.dart';

class HomeSliverAppBarInSliver extends StatelessWidget {
  const HomeSliverAppBarInSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverOverlapAbsorber(
        sliver: const SliverSafeArea(
          sliver: HomeSliverAppBar(),
        ),
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
    );
  }
}

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> buttonLabels = [
      "All",
    ];

    buttonLabels.addAll(AllowedExtensions.categories.keys.toList());

    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      floating: true,
      title: TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        unselectedLabelColor: kGrayColor,
        tabs: List.generate(buttonLabels.length, (index) {
          return TabItem(title: buttonLabels[index]);
        }),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
