import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possch/src/core/cubit/button_pressed_cubit.dart';
import 'package:possch/src/core/extensions/double_extension.dart';
import 'package:possch/src/core/messages/messages.dart';
import 'package:possch/src/core/widgets/buttons/default_button.dart';
import 'package:possch/src/features/registration/domain/entities/registration_account_validation.dart';
import 'package:possch/src/features/registration/presentation/cubit/account_validation_cubit.dart';
import 'package:possch/src/features/registration/presentation/cubit/registration_data_cubit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/inputs/text_input_field.dart';

class RegistrationAccountForm extends StatelessWidget {
  RegistrationAccountForm({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        defaultPadding.heightSizedBox,
        BlocBuilder<AccountValidationCubit, RegistrationAccountValidation?>(
          builder: (context, state) {
            return TextInputField(
              labelText: "enter your email here",
              controller: _emailController,
              errorText: state == null
                  ? null
                  : state.isEmailValid
                      ? state.isEmailFormatValid
                          ? null
                          : errorEmailFormat
                      : errorEmailEmpty,
            ).child;
          },
        ),
        defaultPadding.heightSizedBox,
        BlocBuilder<AccountValidationCubit, RegistrationAccountValidation?>(
          builder: (context, state) {
            return TextInputField(
                    hintText: "Enter your password here",
                    obscureText: true,
                    errorText: state == null
                        ? null
                        : state.isPasswordValid
                            ? null
                            : errorPasswordEmpty,
                    controller: _passwordController)
                .child;
          },
        ),
        defaultPadding.heightSizedBox,
        BlocBuilder<ButtonPressedCubit, bool>(
          builder: (context, state) {
            return DefaultButton(
                    onPressed: state
                        ? null
                        : () {
                            context.read<AccountValidationCubit>().validate(
                                _emailController.text,
                                _passwordController.text);
                            context.read<RegistrationDataCubit>().initAccount(
                                email: _emailController.text,
                                password: _passwordController.text);
                          },
                    text: "CREATE ACCOUNT")
                .child;
          },
        )
      ],
    );
  }
}
