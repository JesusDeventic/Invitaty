import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/core/global_variables.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/page/home/home_page.dart';
import 'package:invitaty/page/users/account_profile_page.dart';
import 'package:invitaty/page/home/splash_screen_page.dart';
import 'package:invitaty/page/login/forgot_password_page.dart';
import 'package:invitaty/page/login/login_page.dart';
import 'package:invitaty/page/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invitaty/page/invitation/viewer_screen.dart';
import 'package:invitaty/page/invitation/editor_screen.dart';
import 'package:invitaty/page/editors/edit_text_module_screen.dart';
import 'package:invitaty/page/editors/edit_countdown_module_screen.dart';

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
      // Modo invitado permitido:
      // - En splash intentamos restaurar sesión si hay token.
      // - Si no hay sesión, no forzamos login; la app entra igualmente en Home.
      if (location == AppRoutes.splash && globalCurrentUser.username.isEmpty) {
        await loginUser();
      }
      if (globalCurrentUser.username.isNotEmpty &&
          authRoutes.contains(location)) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreenPage(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginPage()),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(path: AppRoutes.home, builder: (_, __) => const HomePage()),
      GoRoute(
        path: AppRoutes.accountProfile,
        builder: (_, __) => const AccountProfilePage(),
      ),
      GoRoute(path: AppRoutes.viewer, builder: (_, __) => const ViewerScreen()),
      GoRoute(path: AppRoutes.editor, builder: (_, __) => const EditorScreen()),
      GoRoute(
        path: '/edit-text',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;

          return EditTextModuleScreen(
            index: extra["index"],
            section: extra["section"],
          );
        },
      ),
      GoRoute(
        path: '/edit-countdown',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return EditCountdownModuleScreen(
            index: extra["index"],
            section: extra["section"],
          );
        },
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
