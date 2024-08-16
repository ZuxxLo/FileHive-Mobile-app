import 'package:filehive/core/utils/api/api_service.dart';
import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/router/router.dart';
import 'package:filehive/core/utils/service_locator.dart';
import 'package:filehive/core/widgets/animated_visibility.dart';
import 'package:filehive/features/authentication/presentation/manager/user_bloc/user_bloc.dart';
import 'package:filehive/features/upload_file/data/repositories/repositories/upload_file_repo_impl.dart';
import 'package:filehive/features/upload_file/presentation/manager/file_upload_bloc/file_upload_bloc.dart';
import 'package:filehive/features/upload_file/presentation/views/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FAB extends StatefulWidget {
  const FAB({
    super.key,
    required this.scrollController,
    required this.key1,
  });

  final ScrollController scrollController;
  final GlobalKey<State<StatefulWidget>> key1;

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )
    ..addListener(() {
      setState(() {});
    })
    ..forward(); // Initialize the animation to show the FAB

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse();
        }
      } else if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_controller.status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedVisibility(
      isVisible: _controller.status == AnimationStatus.completed,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
          )
        ]),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          child: const Icon(Icons.upload),
          onPressed: () {
            Navigator.of(context).push(creatroute(
                BlocProvider(
                  create: (context) => FileUploadBloc(
                      uploadFileRepo: UploadFileRepoImpl(
                          ServiceLocator.getIt.get<ApiService>()),
                      userBloc: ServiceLocator.getIt.get<UserBloc>()),
                  child: const UploadFile(),
                ),
                widget.key1.globalPaintBounds!.center,
                200.0));
            // Navigator.of(context).pushNamed(RouteNames.uploadFileScreen);
          },
        ),
      ),
    );
  }
}
