import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/core/global_variables.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/page/home/home_placeholder_page.dart';
import 'package:invitaty/page/messages/private_conversations_page.dart';
import 'package:invitaty/page/messages/private_chat_page.dart';
import 'package:invitaty/page/users/account_profile_page.dart';
import 'package:invitaty/page/users/public_user_profile_page.dart';
import 'package:invitaty/page/home/splash_screen_page.dart';
import 'package:invitaty/page/login/forgot_password_page.dart';
import 'package:invitaty/page/login/login_page.dart';
import 'package:invitaty/page/login/register_page.dart';
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
      final isPublicProfileRoute = location.startsWith('/user/');
      if (globalCurrentUser.username.isEmpty &&
          !authRoutes.contains(location) &&
          !isPublicProfileRoute) {
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
      GoRoute(
        path: AppRoutes.publicProfile,
        builder: (_, state) {
          final username = state.pathParameters['username'] ?? '';
          return PublicUserProfilePage(username: username);
        },
      ),
      GoRoute(
        path: AppRoutes.conversations,
        builder: (_, __) => const PrivateConversationsPage(),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (_, state) {
          final userId = int.tryParse(state.pathParameters['userId'] ?? '') ?? 0;
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return PrivateChatPage(
            recipientId: userId,
            recipientUsername: extra['username'] as String? ?? '',
            recipientAvatarUrl: extra['avatarUrl'] as String? ?? '',
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
