import 'package:dio/dio.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/features/authentication/presentation/manager/user_bloc/user_bloc.dart';
import 'package:filehive/features/authentication/data/models/user_repo_model.dart';
import 'package:filehive/features/authentication/data/repositories/user_info_repo_impl.dart';
import 'package:filehive/features/home/data/repositories/list_my_files_repo_impl.dart';
import 'package:filehive/features/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

import 'api/api_service.dart';

abstract class ServiceLocator {
  static final getIt = GetIt.instance;

  static Future<void> setupServiceLocator() async {
    final dio = Dio();
    dio.interceptors.add(ConnectivityInterceptor());

    getIt.registerSingleton<ApiService>(ApiService(dio));

    final userRepository = UserRepository();
    await userRepository.loadUserToken();
    getIt.registerSingleton<UserRepository>(userRepository);

    final userBloc = UserBloc(
      userRepository,
      UserInfoRepoImpl(getIt<ApiService>()),
    );
    final homeBloc = HomeBloc(
      ListMyFilesRepoImpl(getIt<ApiService>()),
      userBloc,
    );
    userBloc.add(LoadUserEvent());

    getIt.registerSingleton<UserBloc>(userBloc);
    getIt.registerSingleton<HomeBloc>(homeBloc);
  }
}
