import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/core/api_error_messages.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/controller/recaptcha_controller.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/page/users/contact_page.dart';
import 'package:filmaniak/routes/app_routes.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:filmaniak/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FocusNode _loginFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _sendCodeButtonFocusNode = FocusNode();
  final FocusNode _confirmButtonFocusNode = FocusNode();
  bool _showCodeAndPassword = false;
  bool _obscureText = true;
  bool _isLoadingSend = false;
  bool _isLoadingConfirm = false;

  @override
  void initState() {
    super.initState();
    RecaptchaService.showBadge();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _loginFocusNode.dispose();
    _codeFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _sendCodeButtonFocusNode.dispose();
    _confirmButtonFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;
    unFocusGlobal();
    setState(() => _isLoadingSend = true);
    try {
      final isNotBot = await RecaptchaService.isNotABot();
      if (!isNotBot) {
        showCustomSnackBar(S.current.recaptchaError, type: -1);
        return;
      }
      final result = await FilmaniakApi.forgotPassword(_loginController.text.trim());
      if (!mounted) return;
      if (result['success'] == true) {
        setState(() => _showCodeAndPassword = true);
        showCustomSnackBar(S.current.codeSent, type: 1);
        RecaptchaService.hideBadge();
      } else {
        showCustomSnackBar(getAuthErrorMessage(result['code'] as String?), type: -1);
      }
    } finally {
      if (mounted) setState(() => _isLoadingSend = false);
    }
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;
    unFocusGlobal();
    setState(() => _isLoadingConfirm = true);
    try {
      final code = _codeController.text.replaceAll(RegExp(r'\D'), '');
      if (code.length != 6) {
        showCustomSnackBar(S.current.code6Digits, type: -1);
        return;
      }
      final result = await FilmaniakApi.resetPassword(
        login: _loginController.text.trim(),
        code: code,
        newPassword: _passwordController.text,
      );
      if (!mounted) return;
      if (result['success'] == true) {
        showCustomSnackBar(S.current.passwordChanged, type: 1);
        context.go(AppRoutes.login);
      } else {
        showCustomSnackBar(getAuthErrorMessage(result['code'] as String?), type: -1);
      }
    } finally {
      if (mounted) setState(() => _isLoadingConfirm = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios de idioma para reconstruir toda la pantalla de recuperar contraseña
    Provider.of<LanguageProvider>(context);
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
                    children: [
                      rowSettingsAppAndVersion(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildLogo(context),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _loginController,
                              focusNode: _loginFocusNode,
                              decoration: InputDecoration(
                                labelText: S.current.userOrEmail,
                                prefixIcon: const Icon(Icons.person_outline),
                                border: const OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                _sendCodeButtonFocusNode.requestFocus();
                              },
                              validator: (v) =>
                                  (v == null || v.isEmpty) ? S.current.fieldRequired : null,
                            ),
                            if (!_showCodeAndPassword) ...[
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              focusNode: _sendCodeButtonFocusNode,
                              onPressed: _isLoadingSend ? null : _sendCode,
                              child: _isLoadingSend
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Text(S.current.sendCode),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () => context.go(AppRoutes.login),
                              child: Text(S.current.back),
                            ),
                          ),
                            ],
                            if (_showCodeAndPassword) ...[
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _codeController,
                                focusNode: _codeFocusNode,
                            decoration: InputDecoration(
                              labelText: S.current.verificationCode,
                              prefixIcon: const Icon(Icons.pin_outlined),
                              border: const OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                _passwordFocusNode.requestFocus();
                              },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (v) {
                              if (v == null || v.isEmpty) return S.current.fieldRequired;
                              if (v.length != 6) return S.current.code6Digits;
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: S.current.newPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _obscureText ? Icons.visibility_off : Icons.visibility),
                                onPressed: () => setState(() => _obscureText = !_obscureText),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              _confirmPasswordFocusNode.requestFocus();
                            },
                            validator: (v) {
                              if (v == null || v.isEmpty) return S.current.fieldRequired;
                              if (v.length < 6) return S.current.passwordMinLength;
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocusNode,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: S.current.confirmPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () =>
                                    setState(() => _obscureText = !_obscureText),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _resetPassword(),
                            validator: (v) {
                              if (v == null || v.isEmpty) return S.current.fieldRequired;
                              if (v != _passwordController.text) return S.current.passwordMismatch;
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              focusNode: _confirmButtonFocusNode,
                              onPressed: _isLoadingConfirm ? null : _resetPassword,
                              child: _isLoadingConfirm
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Text(S.current.confirm),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () => setState(() => _showCodeAndPassword = false),
                              child: Text(S.current.back),
                            ),
                          ),
                            ],
                          ],
                        ),
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
