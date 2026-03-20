import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/core/global_variables.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/routes/app_routes.dart';
import 'package:filmaniak/controller/recaptcha_controller.dart';
import 'dart:io';
import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  String _info = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );
    _controller.forward();
    _startApp();
  }

  Future<void> _startApp() async {
    if (kIsWeb) {
      await RecaptchaService.initiate();
    }
    setState(() => _info = S.current.loading);
    await _checkServerStatusAndNavigate();
  }

  Future<void> _checkServerStatusAndNavigate() async {
    try {
      final status = await FilmaniakApi.getStatus();
      if (!mounted) return;

      if (status == null) {
        await _showErrorDialog(
          S.current.dialogErrorTitle,
          S.current.dialogErrorServerConnection,
          false,
        );
        return;
      }

      globalServerAppStatus = status;

      // Comparar versión app (si la app es más antigua que la requerida en servidor)
      if (status.version.isNotEmpty &&
          compareVersions(globalCurrentVersionApp, status.version) < 0) {
        await _showErrorDialog(
          S.current.dialogErrorTitle,
          '${S.current.dialogErrorAppVersion}\n\n'
          '${S.current.currentAppVersionText}: $globalCurrentVersionApp\n'
          '${S.current.currentServerVersionText}: ${status.version}',
          true,
        );
        return;
      }

      // Comprobar mantenimiento (status == 0 => mantenimiento)
      if (status.status == 0) {
        await _showErrorDialog(
          S.current.dialogErrorTitle,
          S.current.dialogErrorServerMaintenance,
          false,
        );
        return;
      }

      // Todo OK: continuar flujo normal
      _navigate();
    } catch (_) {
      if (!mounted) return;
      await _showErrorDialog(
        S.current.dialogErrorTitle,
        S.current.dialogErrorServerConnection,
        false,
      );
    }
  }

  void _navigate() {
    if (globalCurrentUser.username.isEmpty) {
      context.go(AppRoutes.login);
    } else {
      context.go(AppRoutes.home);
    }
  }

  Future<void> _showErrorDialog(
    String title,
    String message,
    bool isBlockingUpdate,
  ) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(
          message,
          textAlign: TextAlign.justify,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    // Cerrar la app como en Fitcron / menú principal
                    exit(0);
                  },
                  child: Text(S.current.close),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.6, 0.8, curve: Curves.easeInOut),
                  ),
                ),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildSplashImage(),
                ),
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.6, 0.8, curve: Curves.easeInOut),
                  ),
                ),
                child: _buildLogoImage(),
              ),
            ),
            if (_info.isNotEmpty)
              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: Center(
                  child: Text(
                    _info,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildSplashImage() {
    return Image.asset(
      'assets/logo.png',
      height: MediaQuery.of(context).size.height / 3,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.movie_creation_outlined,
        color: Colors.white54,
        size: 120,
      ),
    );
  }

  Widget _buildLogoImage() {
    return Image.asset(
      'assets/logo.png',
      height: MediaQuery.of(context).size.height / 3,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Text(
        S.current.appName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
