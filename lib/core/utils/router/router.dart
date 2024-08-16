import 'package:filehive/core/utils/api/api_service.dart';
import 'package:filehive/core/utils/service_locator.dart';
import 'package:filehive/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:filehive/features/authentication/presentation/manager/user_bloc/user_bloc.dart';
import 'package:filehive/features/authentication/data/repositories/login_repo_impl.dart';
import 'package:filehive/features/authentication/data/repositories/sign_up_repo_impl.dart';
import 'package:filehive/features/authentication/presentation/views/login/login_screen.dart';
import 'package:filehive/features/authentication/presentation/views/sign_up/sign_up.dart';
import 'package:filehive/features/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:filehive/features/home/presentation/views/home.dart';
import 'package:filehive/features/upload_file/data/repositories/repositories/upload_file_repo_impl.dart';
import 'package:filehive/features/upload_file/presentation/manager/file_upload_bloc/file_upload_bloc.dart';
import 'package:filehive/features/upload_file/presentation/views/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes_names.dart';

class RouterApp {
  static Route animatedSlideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const beginOffset = Offset(1.0, 0.0);
        const endOffset = Offset.zero;
        const curve = Curves.easeInOut;

        var offsetTween = Tween(begin: beginOffset, end: endOffset)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(offsetTween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 350),
    );
  }

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    UserBloc userBloc = ServiceLocator.getIt.get<UserBloc>();
    ApiService apiService = ServiceLocator.getIt.get<ApiService>();
    HomeBloc homeBloc = ServiceLocator.getIt.get<HomeBloc>();

    AuthBloc authBloc = AuthBloc(
        loginRepo: LoginRepoImpl(apiService),
        signUpRepo: SignUpRepoImpl(apiService));
    switch (settings.name) {
      case (RouteNames.home):
        return animatedSlideRoute(BlocProvider(
          create: (context) => homeBloc..add(LoadMyFilesEvent()),
          child: const HomePage(),
        ));
      case (RouteNames.loginScreen):
        return animatedSlideRoute(BlocProvider(
          create: (context) => authBloc,
          child: const LoginScreen(),
        ));

      // the bloc is already created in LoginScreen
      case (RouteNames.signupScreen):
        return animatedSlideRoute(BlocProvider.value(
          value: authBloc,
          child: const SignUpScreen(),
        ));
      case (RouteNames.uploadFileScreen):
        return animatedSlideRoute(BlocProvider(
          create: (context) => FileUploadBloc(
              uploadFileRepo: UploadFileRepoImpl(apiService),
              userBloc: userBloc),
          child: const UploadFile(),
        ));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}
//////////// to creat telegram like route transition/animation

Route creatroute(var route, Offset offset, var circularRadius) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        double beginRadius = 0;
        double endRadius = MediaQuery.of(context).size.height * 1.2;

        return ClipPath(
          clipper: CircleTransitionClipper(
              offset,
              animation.drive(Tween(begin: beginRadius, end: endRadius)).value,
              circularRadius),
          child: child,
        );
      });
}

//////////// to get positions of a widget on the screen

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final matrix = renderObject?.getTransformTo(null);

    if (matrix != null && renderObject?.paintBounds != null) {
      final rect = MatrixUtils.transformRect(matrix, renderObject!.paintBounds);
      return rect;
    } else {

      print("-----------");
      return null;
    }
  }
}

class CircleTransitionClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;
  final double circularRadius;

  CircleTransitionClipper(this.center, this.radius, this.circularRadius);
  @override
  getClip(Size size) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromCircle(center: center, radius: radius),
          Radius.circular(circularRadius)));
  } //addOval(Rect.fromCircle(center: center, radius: radius));

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
