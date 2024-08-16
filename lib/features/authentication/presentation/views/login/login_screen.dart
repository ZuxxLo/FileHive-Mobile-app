import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/helper/helper_functions.dart';
import 'package:filehive/core/utils/other_constants.dart';
import 'package:filehive/core/utils/router/routes_names.dart';
import 'package:filehive/core/utils/service_locator.dart';
import 'package:filehive/core/widgets/custom_button.dart';
import 'package:filehive/core/widgets/filehive_logo.dart';
import 'package:filehive/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:filehive/features/authentication/presentation/manager/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/dont_have_account_section.dart';
import 'widgets/form_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBlocState = ServiceLocator.getIt<UserBloc>().state;
    if (userBlocState is UserAuthenticatedExpiredToken) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          HelperFunctions.showdDialog(
              context: context,
              title: "Disconnected",
              message: userBlocState.errMessage));
    }

    final formKey = GlobalKey<FormState>();
    void onPressedCustomButton(BuildContext context) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        FocusManager.instance.primaryFocus?.unfocus();
        AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
          loginFormModel: authBloc.loginFormModel,
        ));
      }
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[gradientColorBegin, gradientColorEnd]),
      ),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: ListView(
          padding: const EdgeInsets.only(top: 100),
          children: [
            const SizedBox(
                height: 50,
                width: 50,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  child: FilehiveLogo(),
                )),
            const SizedBox(height: 30),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: kSecondaryColor),
                    color: Colors.white,
                    borderRadius: generalBorderRadius),
                child: Column(
                  children: [
                    FormSection(
                      formKey: formKey,
                      onPressedCustomButton: () =>
                          onPressedCustomButton(context),
                    ),
                    BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is LoginLoading) {
                            HelperFunctions.showdDialog(
                                context: context, loading: true, canPop: false);
                          } else if (state is LoginFailure) {
                            HelperFunctions.showdDialog(
                                context: context, title: state.errorMessage);
                          } else if (state is LoginSuccess) {
                            //close the loading dialog
                            Navigator.of(context, rootNavigator: true).pop();

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RouteNames.home,
                                (Route<dynamic> route) => false);
                          }
                        },
                        child: CustomButton(
                          fixSizeAll: true,
                          text: "Login",
                          onPressed: () async {
                            onPressedCustomButton(context);
                          },
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const DontHaveAccountSection(),
          ],
        ),
      ),
    );
  }
}
