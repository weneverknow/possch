import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:possch/src/features/authentication/presentation/authentication_screen.dart';
import 'package:possch/src/features/dashboard/presentation/dashboard_screen.dart';

import 'features/authentication/domain/usecase/login_from_storage_usecase.dart';
import 'features/authentication/domain/usecase/login_with_email_usecase.dart';
import 'features/authentication/domain/usecase/logout_usecase.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'service_locator.dart' as service;

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      context.go(event.link.path);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
          service.sl<LoginWithEmailUseCase>(),
          service.sl<LoginFromStorageUseCase>(),
          service.sl<LogoutUseCase>())
        ..add(AuthenticationLoginFromStorage()),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSuccess) {
            return const DashboardScreen();
          }
          return const AuthenticationScreen();
        },
      ),
    );
  }
}
