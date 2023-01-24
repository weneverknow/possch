import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:possch/src/core/widgets/texts/title_text.dart';
import 'package:possch/src/features/authentication/presentation/bloc/authentication_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: "DASHBOARD").child,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(AuthenticationLogout());
              },
              child: const Text("logout")),
          TextButton(
              onPressed: () {
                context.go('/profile');
              },
              child: const Text("go to profile"))
        ],
      ),
    );
  }
}
