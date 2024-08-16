import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/widgets/filehive_logo.dart';
import 'package:filehive/core/widgets/search_icon.dart';
import 'package:flutter/material.dart';

class HomeAppBarInSliver extends StatelessWidget {
  const HomeAppBarInSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      titleSpacing: 0,
      title: const HomeAppBar(),
      bottom: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [gradientColorBegin, gradientColorEnd])),
            height: 1,
          )),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 100,
      leading: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: FilehiveLogo(),
      ),
      actions: [
        IconButton(
            color: kPrimaryColor, onPressed: () {}, icon: const SearchIcon()),
        const SizedBox(width: 2)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
