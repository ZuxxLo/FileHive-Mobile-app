import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/helper/helper_functions.dart';
import 'package:filehive/core/utils/other_constants.dart';
import 'package:filehive/core/widgets/custom_button.dart';
import 'package:filehive/core/widgets/filehive_logo.dart';
import 'package:filehive/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:filehive/features/authentication/presentation/views/sign_up/widgets/form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/simple_back_app_bar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    void onPressedCustomButton(BuildContext context) {
      FocusManager.instance.primaryFocus?.unfocus();

      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        FocusManager.instance.primaryFocus?.unfocus();

        AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
        BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
          signUpFormModel: authBloc.signUpFormModel,
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
        appBar: const SimpleBackAppBar(),
        backgroundColor: transparentColor,
        body: ListView(
          padding: const EdgeInsets.only(top: 20),
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
                        if (state is SignUpLoading) {
                          HelperFunctions.showdDialog(
                              context: context, message: null, loading: true);
                        } else if (state is SignUpFailure) {
                          HelperFunctions.showdDialog(
                              context: context, message: state.errorMessage);
                        } else if (state is SignUpSuccess) {
                          Navigator.of(context).pop();
                          HelperFunctions.showdDialog(
                              context: context,
                              title: state.successMessage,
                              message:
                                  "To activate your account, Please click the activation link we sent to your email");
                        }
                      },
                      child: CustomButton(
                        fixSizeAll: true,
                        text: "Create an account",
                        onPressed: () => onPressedCustomButton(context),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
