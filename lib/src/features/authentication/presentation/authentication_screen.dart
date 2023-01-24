import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:possch/src/core/constants/constants.dart';
import 'package:possch/src/core/cubit/button_pressed_cubit.dart';
import 'package:possch/src/core/extensions/double_extension.dart';
import 'package:possch/src/core/messages/messages.dart';
import 'package:possch/src/core/widgets/buttons/default_button.dart';
import 'package:possch/src/core/widgets/dialog_widget.dart';
import 'package:possch/src/core/widgets/inputs/text_input_field.dart';
import 'package:possch/src/core/widgets/texts/sub_title_text.dart';
import 'package:possch/src/features/authentication/domain/repository/authentication_validation.dart';
import 'package:possch/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:possch/src/features/authentication/presentation/cubit/authentication_validation_cubit.dart';
import 'package:possch/src/features/authentication/presentation/cubit/visibility_password_cubit.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VisibilityPasswordCubit()),
        BlocProvider(create: (_) => ButtonPressedCubit()),
        BlocProvider(create: (_) => AuthenticationValidationCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
            if (state is AuthenticationFailed) {
              context.read<ButtonPressedCubit>().update();
              showErrorDialog(context, title: "Failed", message: state.message);
            }
          }),
          BlocListener<AuthenticationValidationCubit,
              AuthenticationValidation?>(listener: (context, state) {
            if (state != null) {
              if (state.isEmailFormatValid &&
                  state.isEmailValid &&
                  state.isPasswordValid) {
                context.read<ButtonPressedCubit>().update();
                context.read<AuthenticationBloc>().add(
                    AuthenticationLoginWithEmail(
                        _emailController.text, _passwordController.text));
              }
            }
          })
        ],
        child: Scaffold(
          body: Container(
            constraints: BoxConstraints(
              minHeight: size.height,
              minWidth: size.width,
            ),
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login-bg.png"),
                    fit: BoxFit.cover)),
            alignment: Alignment.center,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Hello Again!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                (defaultPadding / 2).heightSizedBox,
                SubTitleText(
                  text: "Welcome back you've been missed",
                  textAlign: TextAlign.center,
                ).child,
                (defaultPadding * 2).heightSizedBox,
                BlocBuilder<AuthenticationValidationCubit,
                    AuthenticationValidation?>(
                  builder: (context, state) {
                    return TextInputField(
                            controller: _emailController,
                            hintText: "Enter your email here",
                            inputType: TextInputType.emailAddress,
                            errorText: state != null
                                ? (state.isEmailValid
                                    ? (state.isEmailFormatValid
                                        ? null
                                        : errorEmailFormat)
                                    : errorEmailEmpty)
                                : null)
                        .child;
                  },
                ),
                defaultPadding.heightSizedBox,
                BlocBuilder<VisibilityPasswordCubit, bool>(
                    builder: (context, state) {
                  return BlocBuilder<AuthenticationValidationCubit,
                      AuthenticationValidation?>(
                    builder: (context, validState) {
                      return TextInputField(
                              controller: _passwordController,
                              hintText: "Enter your password here",
                              obscureText: !state,
                              errorText: validState != null
                                  ? (validState.isPasswordValid
                                      ? null
                                      : errorPasswordEmpty)
                                  : null,
                              suffixIcon: buildSuffixPassword(context, !state))
                          .child;
                    },
                  );
                }),
                defaultPadding.heightSizedBox,
                BlocBuilder<ButtonPressedCubit, bool>(
                  builder: (context, state) {
                    return DefaultButton(
                            text: state ? "PLEASE WAIT" : "SIGN IN",
                            onPressed: state
                                ? null
                                : () {
                                    context
                                        .read<AuthenticationValidationCubit>()
                                        .validate(_emailController.text,
                                            _passwordController.text);
                                  })
                        .child;
                  },
                ),
                defaultPadding.heightSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubTitleText(
                      text: "don't have an account? ",
                    ).child,
                    GestureDetector(
                      onTap: () {
                        context.go('/registration');
                      },
                      child: SubTitleText(
                        text: "create an account",
                        color: primaryColor,
                      ).child,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSuffixPassword(BuildContext context, bool visible) {
    return GestureDetector(
        onTap: () {
          context.read<VisibilityPasswordCubit>().update();
        },
        child: Icon(visible ? Icons.visibility : Icons.visibility_off));
  }
}
