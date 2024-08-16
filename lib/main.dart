import 'dart:async';

import 'package:filehive/core/utils/app_bloc_observer.dart';
import 'package:filehive/core/utils/shared_preferences/pref_utils.dart';
import 'package:filehive/core/utils/theme.dart';
import 'package:filehive/features/authentication/presentation/manager/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/router/router.dart';
import 'core/utils/router/routes_names.dart';
import 'core/utils/service_locator.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils.initSharredPreferences();

  await ServiceLocator.setupServiceLocator();

  // Load user and determine state synchronously
  // Wait for UserBloc to process the event
  await _initializeUserState();

  runApp(const MyApp());
}

Future<void> _initializeUserState() async {
  final completer = Completer<void>();

  StreamSubscription<UserState>? subscription; // Declare the subscription

  subscription = ServiceLocator.getIt<UserBloc>().stream.listen((state) {
    print("hmmm state is $state");
    // if (state is UserAuthenticated || state is UserUnAuthenticated) {
    completer.complete();
    subscription!.cancel(); // Cancel the subscription
    // }
  });

  await completer.future;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ServiceLocator.getIt<UserBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'File Hive',
        theme: CustomTheme.theme,
        initialRoute: _getInitialRoute(context), //_getInitialRoute(context),
        onGenerateRoute: RouterApp.generateRoutes,
      ),
    );
  }

  String _getInitialRoute(BuildContext context) {
    var state = ServiceLocator.getIt<UserBloc>().state;

    print("statestatestatestatestate");
    print(state);

    if (state is UserUnAuthenticated) {
      return RouteNames.loginScreen;
    } else if (state is UserAuthenticated) {
      return RouteNames.home;
    } else if (state is UserAuthenticatedExpiredToken) {
      return RouteNames.loginScreen;
    }
    // Fallback route if state is not determined

    return RouteNames.loginScreen;
  }
}
