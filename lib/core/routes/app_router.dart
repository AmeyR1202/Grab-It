import 'package:go_router/go_router.dart';
import 'package:grab_it/core/notifiers/auth_notifier.dart';
import 'package:grab_it/features/enter_number/presentation/pages/enter_number_page.dart';
import 'package:grab_it/features/enter_otp/presentation/pages/enter_otp_page.dart';
import 'package:grab_it/features/welcome/presentation/pages/welcome_page.dart';
import 'package:grab_it/features/splash/presentation/pages/splash_page.dart';

final authNotifier = AuthNotifier();

final GoRouter router = GoRouter(
  initialLocation: '/welcome',

  refreshListenable: authNotifier, // listen to user status of sign in or out
  // TODO: write redeirect logic here if user -== null then take to loginpage or home if logged in
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/welcome', builder: (context, state) => const WelcomePage()),
    GoRoute(
      path: '/enter-number',
      builder: (context, state) => const EnterNumberPage(),
    ),
    GoRoute(
      path: '/enter-otp',
      builder: (context, state) => const EnterOtpPage(),
    ),
  ],
);
