import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_state.dart';
import 'package:grab_it/features/splash/presentation/pages/splash_page.dart';
import 'package:grab_it/features/welcome/presentation/pages/welcome_page.dart';
import 'package:grab_it/features/enter_number/presentation/pages/enter_number_page.dart';
import 'package:grab_it/features/enter_otp/presentation/pages/enter_otp_page.dart';
import 'package:grab_it/features/auth/presentation/pages/profile_setup_page.dart';
import 'package:grab_it/features/home/presentation/pages/home_page.dart';
import 'package:grab_it/features/merchant/presentation/pages/merchant_dashboard_page.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: '/splash',

    refreshListenable: GoRouterRefreshStream(authBloc.stream),

    redirect: (context, state) {
      final authState = authBloc.state;

      final location = state.matchedLocation;

      // Global Route Guards
      final isAuthRoute =
          location == '/welcome' ||
          location == '/enter-number' ||
          location == '/enter-otp' ||
          location == '/profile-setup';

      // 1. Unauthenticated users should be blocked from accessing protected routes
      if (authState is AuthInitial || authState is AuthFailureState) {
        return isAuthRoute ? null : '/welcome';
      }

      // 2. Authenticated users should not be able to go backwards to the login screens
      if (authState is AuthUserExistsState) {
        final target = authState.user.role == 'owner' ? '/merchant-dashboard' : '/home';
        return isAuthRoute ? target : null;
      }

      return null;
    },

    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),

      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),

      GoRoute(
        path: '/enter-number',
        builder: (context, state) => const EnterNumberPage(),
      ),

      GoRoute(
        path: '/enter-otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};

          return EnterOtpPage(
            verificationId: extra['verificationId'] as String? ?? '',
            userExists: extra['userExists'] as bool? ?? false,
            phoneNumber: extra['phoneNumber'] as String? ?? '',
          );
        },
      ),

      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupPage(),
      ),

      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: '/merchant-dashboard',
        builder: (context, state) => const MerchantDashboardPage(),
      ),
    ],
  );
}
