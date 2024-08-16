import 'package:filehive/core/utils/helper/allowed_extensions.dart';
import 'package:filehive/features/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:filehive/features/home/presentation/views/widgets/fab.dart';
import 'package:filehive/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:filehive/features/home/presentation/views/widgets/home_sliver_app_bar.dart';
import 'package:filehive/features/home/presentation/views/widgets/home_tab_bar_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController =
        BlocProvider.of<HomeBloc>(context).scrollController;
    GlobalKey key1 = GlobalKey();

    return SafeArea(
      child: Scaffold(
          floatingActionButton: FAB(
            key: key1,
            key1: key1,
            scrollController: scrollController,
          ),
          body: DefaultTabController(
            length: AllowedExtensions.categories.keys.length + 1, //ta3 all
            child: Scaffold(
              body: NestedScrollView(
                controller: scrollController,
                floatHeaderSlivers: true,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    const HomeAppBarInSliver(),
                    const HomeSliverAppBarInSliver(),
                  ];
                },
                body: const HomeTabBarViewBody(),
              ),
            ),
          )),
    );
  }
}
