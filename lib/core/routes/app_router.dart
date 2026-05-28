import 'package:go_router/go_router.dart';
import 'package:grab_it/core/notifiers/auth_notifier.dart';
import 'package:grab_it/features/splash/presentation/pages/splash_page.dart';

final authNotifier = AuthNotifier();

final GoRouter router = GoRouter(
  initialLocation: '/splash',

  refreshListenable: authNotifier, // listen to user status of sign in or out
  // TODO: write redeirect logic here if user -== null then take to loginpage or home if logged in
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
  ],
);
