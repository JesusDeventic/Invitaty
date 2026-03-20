import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/core/api_error_messages.dart';
import 'package:filmaniak/core/user_preferences.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/core/global_variables.dart';
import 'package:filmaniak/controller/recaptcha_controller.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/user_model.dart';
import 'package:filmaniak/page/users/contact_page.dart';
import 'package:filmaniak/routes/app_routes.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:filmaniak/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _keepSession = true;
  bool _isLoading = false;
  bool _isButtonDisabled = false;
  int _countDown = 0;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    RecaptchaService.showBadge();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _startCountDown() {
    setState(() {
      _countDown = 5;
      _isButtonDisabled = true;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          _isButtonDisabled = false;
          timer.cancel();
        }
      });
    });
  }

  Future<void> _submitLogin() async {
    if (_isButtonDisabled) return;
    if (!_formKey.currentState!.validate()) return;
    unFocusGlobal();
    final isNotBot = await RecaptchaService.isNotABot();
    if (!isNotBot) {
      showCustomSnackBar(S.current.recaptchaError, type: -1);
      return;
    }
    setState(() {
      _isLoading = true;
      _isButtonDisabled = true;
    });
    try {
      final result = await FilmaniakApi.login(
        login: _loginController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      if (result['success'] == true) {
        final token = result['token'] as String?;
        final userJson = result['user'] as Map<String, dynamic>?;
        if (token != null && userJson != null) {
          await FilmaniakApi.saveToken(token);
          globalCurrentUser = FilmaniakUser.fromJson(userJson);
          await UserPreferences().setCachedUser(globalCurrentUser);
          if (_keepSession) {
            // Token ya guardado en saveToken
          }
          RecaptchaService.hideBadge();
          context.go(AppRoutes.home);
          showCustomSnackBar(S.current.welcome);
          syncPushConfig(); // En segundo plano: registrar token en backend + topic idioma
          return;
        }
      }
      final message = getAuthErrorMessage(result['code'] as String?);
      showCustomSnackBar(message, type: -1);
      _startCountDown();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          if (_countDown == 0) _isButtonDisabled = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios de idioma para reconstruir toda la pantalla (como en Fitcron)
    Provider.of<LanguageProvider>(context); // listen: true por defecto
    final screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: unFocusGlobal,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              unFocusGlobal();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactPage(),
                ),
              );
            },
            tooltip: S.current.userSectionContact,
            child: const Icon(Icons.support_agent_rounded, size: 30),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startFloat,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: screenWidth > 500 ? 500 : screenWidth,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      rowSettingsAppAndVersion(context),
                      const SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildLogo(context),
                            const SizedBox(height: 24),
                            if (_countDown > 0)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  S.current.loginCountdownMessage(_countDown),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            TextFormField(
                              controller: _loginController,
                              decoration: InputDecoration(
                                labelText: S.current.userOrEmail,
                                prefixIcon: const Icon(Icons.person_outline),
                                border: const OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (v) =>
                                  (v == null || v.isEmpty) ? S.current.fieldRequired : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                labelText: S.current.password,
                                prefixIcon: const Icon(Icons.lock_outline),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: () =>
                                      setState(() => _obscureText = !_obscureText),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _submitLogin(),
                              validator: (v) =>
                                  (v == null || v.isEmpty) ? S.current.fieldRequired : null,
                            ),
                            const SizedBox(height: 8),
                            CheckboxListTile(
                              title: Text(S.current.keepSession),
                              value: _keepSession,
                              onChanged: (_isLoading || _isButtonDisabled)
                                  ? null
                                  : (v) =>
                                      setState(() => _keepSession = v ?? true),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: (_isLoading || _isButtonDisabled)
                                    ? null
                                    : _submitLogin,
                                child: _isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ),
                                      )
                                    : Text(S.current.signIn),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: (_isLoading || _isButtonDisabled)
                                    ? null
                                    : () => context.go(AppRoutes.register),
                                child: Text(S.current.signUp),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: (_isLoading || _isButtonDisabled)
                                    ? null
                                    : () => context.go(AppRoutes.forgotPassword),
                                child: Text(S.current.forgotPassword),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      width: 160,
      errorBuilder: (_, __, ___) => Text(
        S.current.appName,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
