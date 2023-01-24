import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:possch/src/core/constants/constants.dart';
import 'package:possch/src/core/cubit/button_pressed_cubit.dart';
import 'package:possch/src/core/widgets/dialog_widget.dart';
import 'package:possch/src/core/widgets/texts/title_text.dart';
import 'package:possch/src/features/registration/domain/entities/registration_account_validation.dart';
import 'package:possch/src/features/registration/presentation/components/registration_account_form.dart';
import 'package:possch/src/features/registration/presentation/components/registration_store_form.dart';
import 'package:possch/src/features/registration/presentation/cubit/account_validation_cubit.dart';
import 'package:possch/src/features/registration/presentation/cubit/product_type_cubit.dart';
import 'package:possch/src/features/registration/presentation/cubit/register_cubit.dart';
import 'package:possch/src/features/registration/presentation/cubit/registration_data_cubit.dart';
import 'package:possch/src/features/registration/presentation/cubit/registration_page_cubit.dart';
import 'package:possch/src/service_locator.dart';

import '../domain/usecase/create_account_usecase.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductTypeCubit()),
        BlocProvider(create: (_) => RegistrationPageCubit()),
        BlocProvider(create: (_) => StoreValidationCubit()),
        BlocProvider(create: (_) => RegisterCubit(sl<CreateAccountUseCase>())),
        BlocProvider(create: (_) => RegistrationDataCubit()),
        BlocProvider(create: (_) => AccountValidationCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<StoreValidationCubit, String?>(
              listener: (context, state) {
            if (state == null) {
              context.read<RegistrationPageCubit>().move(1);
            }
          }),
          BlocListener<AccountValidationCubit, RegistrationAccountValidation?>(
              listener: (context, state) {
            if (state != null) {
              if (state.isEmailFormatValid &&
                  state.isEmailValid &&
                  state.isPasswordValid) {
                context.read<ButtonPressedCubit>().update();
                context
                    .read<RegisterCubit>()
                    .register(context.read<RegistrationDataCubit>().state!);
              }
            }
          }),
          BlocListener<RegisterCubit, RegisterState>(
              listener: (context, state) async {
            if (state is RegisterCreatedFailed) {
              context.read<ButtonPressedCubit>().update();
              showErrorDialog(context, title: "Failed", message: state.message);
            }
            if (state is RegisterCreatedSuccess) {
              context.read<ButtonPressedCubit>().update();
              Fluttertoast.showToast(
                msg: "User created successfully",
                gravity: ToastGravity.CENTER,
                backgroundColor: primaryColor,
                textColor: secondaryColor,
                toastLength: Toast.LENGTH_LONG,
              ).then((value) => context.go('/'));
            }
          })
        ],
        child: Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/register-bg.png"),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        context.go('/');
                      },
                      icon: const Icon(Icons.close)),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: BlocBuilder<RegistrationPageCubit, int>(
                              builder: (context, state) {
                                return TitleText(
                                        text: state > 0
                                            ? "Create Your Account"
                                            : "Tell Me\nAbout Your Store",
                                        fontSize: 32,
                                        textAlign: TextAlign.left)
                                    .child;
                              },
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: BlocBuilder<RegistrationPageCubit, int>(
                              builder: (context, state) {
                                return state > 0
                                    ? RegistrationAccountForm()
                                    : RegistrationStoreForm();
                              },
                            )),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
