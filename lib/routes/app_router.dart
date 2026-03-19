import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/page/home/home_placeholder_page.dart';
import 'package:filmoly/page/users/account_profile_page.dart';
import 'package:filmoly/page/home/splash_screen_page.dart';
import 'package:filmoly/page/login/forgot_password_page.dart';
import 'package:filmoly/page/login/login_page.dart';
import 'package:filmoly/page/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

GoRouter createAppRouter(GlobalKey<NavigatorState> navigatorKey) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash,
    redirect: (context, state) async {
      final location = state.uri.path;
      const authRoutes = <String>{
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.forgotPassword,
      };
      if (globalCurrentUser.username.isEmpty && !authRoutes.contains(location)) {
        final ok = await loginUser();
        if (!ok && location == AppRoutes.splash) return null;
      }
      if (globalCurrentUser.username.isNotEmpty && authRoutes.contains(location)) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreenPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => const HomePlaceholderPage(),
      ),
      GoRoute(
        path: AppRoutes.accountProfile,
        builder: (_, __) => const AccountProfilePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            Text(state.uri.path),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text(S.current.goToHome),
            ),
          ],
        ),
      ),
    ),
  );
}
