import 'package:filehive/core/errors/api_errors_code.dart';
import 'package:filehive/features/authentication/data/models/user_repo_model.dart';
import 'package:filehive/features/authentication/data/repositories/user_info_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

// String TOKENaaaa =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNzQ5MDIxLCJpYXQiOjE3MjE2NjI2MjEsImp0aSI6IjYzZTA4NWM4MDZkZDRkMTliOWRlYTFkZDdlZjViMzViIiwidXNlcl9pZCI6MiwiZW1haWwiOiJjdm1hbjY5MEBnbWFpbC5jb20iLCJmaXJzdF9uYW1lIjoic3RyaW5nIiwibGFzdF9uYW1lIjoic3RyaW5nIiwicHJvZmlsZVBpY3R1cmUiOiIiLCJpc192ZXJpZmllZCI6dHJ1ZSwiaXNfYWN0aXZlIjp0cnVlfQ.URjN1qrti34gYlrAG1Ify6kklFryCC9eOs_4kSq7HiA";

String expiredToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE0NzMxNjYwLCJpYXQiOjE3MTQ2NDUyNjAsImp0aSI6ImRhMTM2MWNiZDY5MzRjNjc5MGJkMjAxZmU2ODMzMzI2IiwidXNlcl9pZCI6MiwiZW1haWwiOiJyb3VnaW1vaGFtZWQ2NkBnbWFpbC5jb20iLCJmaXJzdF9uYW1lIjoibW9oIiwibGFzdF9uYW1lIjoicm91Z2kiLCJwcm9maWxlUGljdHVyZSI6InVzZXJfMl9tb2hfcm91Z2kvb25lLnBuZyIsImlzX3ZlcmlmaWVkIjp0cnVlLCJpc19hY3RpdmUiOnRydWV9.xtWHDNFS-x-MAaF0d6M1rH3buobWnJiCbDwrBhYB9Hc";


// revise update user event
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final UserInfoRepoImpl userinfosRepository;

  UserBloc(this.userRepository, this.userinfosRepository)
      : super(UserUnAuthenticated()) {
    on<LoadUserEvent>((event, emit) async {
      if (userRepository.accessToken != null) {
        var response = await userinfosRepository.getUserInfos(
            accessToken: userRepository.accessToken!);
        response.fold(
          (failure) {
            print(
                "---------- supposed to be authenticated but problem maybe internet or expired token-----------");
            print(failure.error);

            if (failure.error == ApiErrorsCode.tokenInvalid) {
              print(
                  "UserAuthenticatedExpiredTokenUserAuthenticatedExpiredTokenUserAuthenticatedExpiredToken");
              print(failure.error);

              // they will receive the disconnection message only once
              userRepository.clearUser();
              emit(UserAuthenticatedExpiredToken(
                  errMessage: failure.errMessage));
            } else {
              emit(UserUnAuthenticated());
            }
          },
          (user) {
            userRepository.setUser(user, userRepository.accessToken!);
            print(userRepository.user!.email!);

            emit(UserAuthenticated(userRepository: userRepository));
          },
        );
        // print("User loaded: ${userRepository.user!.email}");
        // emit(UserAuthenticated(userRepository: userRepository));
      } else {
        print("---------- UserUnAuthenticated -----------");
        print("No user found");
        emit(UserUnAuthenticated());
      }
    });

    on<UpdateUserEvent>((event, emit) {
      print(userRepository.user!.email!);
      print("UpdateUserEventUpdateUserEventUpdateUserEvent");

      emit(UserAuthenticated(userRepository: userRepository));
    });

    on<DisconnectUserEvent>(
      (event, emit) {
        userRepository.clearUser();
      },
    );
  }

  @override
  Future<void> close() {
    print("------------user bloc closed----------");

    return super.close();
  }
}
