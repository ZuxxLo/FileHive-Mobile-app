import 'package:filehive/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:filehive/features/authentication/presentation/views/login/widgets/forgot_password_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/other_constants.dart';
import '../../../../../../core/utils/styles_text.dart';
import '../../../../../../core/errors/text_field_validator.dart';
import '../../../../../../core/widgets/email_password_icon.dart';
import '../../../../../../core/widgets/prefix_icon_text_field.dart';

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required this.formKey,
    required this.onPressedCustomButton,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback onPressedCustomButton;

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateEmail(input: value),
              decoration: InputDecoration(
                  prefixIconConstraints: prefixIconBoxConstraints,
                  prefixIcon: const PrefixIconTextField(
                    iconWidget: EmailIcon(),
                  ),
                  hintText: 'Email',
                  hintStyle: StylesText.textHint16),
              onChanged: authBloc.onChangedLoginEmailInput,
            ),
            const SizedBox(height: 10),
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              bool pWVisibility = authBloc.pWVisibility;

              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.go,
                onFieldSubmitted: (value) {
                  onPressedCustomButton();
                },
                validator: (value) =>
                    Validator.validateRequired(input: value, field: 'password'),
                obscureText: !pWVisibility,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: StylesText.textHint16,
                    prefixIconConstraints: prefixIconBoxConstraints,
                    suffixIcon: IconButton(
                      icon: Icon(pWVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () => authBloc.add(TogglePWVisibilityEvent()),
                    ),
                    prefixIcon: const PrefixIconTextField(
                      iconWidget: PasswordIcon(),
                    )),
                onChanged: authBloc.onChangeLoginPasswordInput,
              );
            }),
            const SizedBox(height: 5),
            const ForgotPasswordSection(),
            const SizedBox(height: 20),
          ],
        ));
  }
}
