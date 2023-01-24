import 'package:go_router/go_router.dart';
import 'package:possch/src/features/registration/presentation/registration_screen.dart';
import 'package:possch/src/features/registration/profile_screen.dart';
import 'package:possch/src/landing_page.dart';

GoRouter routes({String? initialLink}) {
  return GoRouter(
    initialLocation: '/',
    routerNeglect: true,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/registration',
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
          path: '/',
          builder: (context, state) => const LandingPage(),
          routes: [
            GoRoute(
                path: 'profile',
                builder: (context, state) => const ProfileScreen())
          ])
    ],
    redirect: (context, state) {
      return initialLink;
    },
  );
}
