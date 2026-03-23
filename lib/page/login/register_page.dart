import 'package:invitaty/api/invitaty_api.dart';
import 'package:invitaty/core/api_error_messages.dart';
import 'package:invitaty/core/user_preferences.dart';
import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/core/global_variables.dart';
import 'package:invitaty/controller/recaptcha_controller.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/model/user_model.dart';
import 'package:invitaty/page/users/contact_page.dart';
import 'package:invitaty/routes/app_routes.dart';
import 'package:invitaty/widget/components_widgets.dart';
import 'package:invitaty/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  bool _obscureText = true;
  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _acceptMarketing = false;

  @override
  void initState() {
    super.initState();
    RecaptchaService.showBadge();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _submitRegister() async {
    if (!_formKey.currentState!.validate()) return;
    unFocusGlobal();
    if (!_acceptTerms) {
      showCustomSnackBar(S.current.registerTermsAndConditionsError, type: -1);
      return;
    }
    final isNotBot = await RecaptchaService.isNotABot();
    if (!isNotBot) {
      showCustomSnackBar(S.current.recaptchaError, type: -1);
      return;
    }
    setState(() => _isLoading = true);
    try {
      final lang = context.read<LanguageProvider>().currentLanguage;
      final result = await InvitatyApi.register(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: _displayNameController.text.trim().isEmpty
            ? null
            : _displayNameController.text.trim(),
        marketingConsent: _acceptMarketing,
        language: lang,
      );
      if (!mounted) return;
      if (result['success'] == true && result['token'] != null) {
        final token = result['token'] as String;
        final userJson = result['user'] as Map<String, dynamic>?;
        if (userJson != null) {
          await InvitatyApi.saveToken(token);
          globalCurrentUser = InvitatyUser.fromJson(userJson);
          await UserPreferences().setCachedUser(globalCurrentUser);
          showCustomSnackBar(S.current.welcome);
          RecaptchaService.hideBadge();
          context.go(AppRoutes.home);
          return;
        }
      }
      final message = getAuthErrorMessage(result['code'] as String?);
      showCustomSnackBar(message, type: -1);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios de idioma para reconstruir toda la pantalla de registro
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
                          controller: _usernameController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
                          decoration: InputDecoration(
                            labelText: S.current.username,
                            prefixIcon: const Icon(Icons.person_outline),
                            border: const OutlineInputBorder(),
                          ),
                          maxLength: 20,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_-]')),
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return S.current.fieldRequired;
                            if (v.length < 4) return S.current.usernameMinLength;
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          focusNode: _emailFocusNode,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                          decoration: InputDecoration(
                            labelText: S.current.email,
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return S.current.fieldRequired;
                            if (!v.contains('@') || !v.contains('.')) return S.current.invalidEmail;
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Campo de nombre para mostrar (opcional) oculto de momento.
                        // TextFormField(
                        //   controller: _displayNameController,
                        //   decoration: InputDecoration(
                        //     labelText: S.current.displayName,
                        //     prefixIcon: const Icon(Icons.badge_outlined),
                        //     border: const OutlineInputBorder(),
                        //   ),
                        //   textInputAction: TextInputAction.next,
                        // ),
                        // const SizedBox(height: 16),
                        TextFormField(
                          focusNode: _passwordFocusNode,
                          controller: _passwordController,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
                          decoration: InputDecoration(
                            labelText: S.current.password,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _obscureText = !_obscureText),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return S.current.fieldRequired;
                            if (v.length < 6) return S.current.passwordMinLength;
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          focusNode: _confirmPasswordFocusNode,
                          controller: _confirmPasswordController,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submitRegister(),
                          decoration: InputDecoration(
                            labelText: S.current.confirmPassword,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _obscureText = !_obscureText),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return S.current.fieldRequired;
                            if (v != _passwordController.text) return S.current.passwordMismatch;
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                value: _acceptTerms,
                                onChanged: (value) {
                                  setState(() => _acceptTerms = value ?? false);
                                },
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  unFocusGlobal();
                                  setState(() => _acceptTerms = !_acceptTerms);
                                },
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: S.current.registerTermsAndConditionsAccept),
                                      TextSpan(
                                        text: ' ${S.current.termsAndConditionsLabel}',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launchUrl(
                                              Uri.parse('https://invitaty.com/terms-and-conditions/'),
                                              mode: LaunchMode.externalApplication,
                                            );
                                          },
                                      ),
                                      TextSpan(text: ' ${S.current.andLabel} '),
                                      TextSpan(
                                        text: S.current.privacyPoliciesLabel,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launchUrl(
                                              Uri.parse('https://invitaty.com/privacy-policy/'),
                                              mode: LaunchMode.externalApplication,
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                value: _acceptMarketing,
                                onChanged: (value) {
                                  setState(() => _acceptMarketing = value ?? false);
                                },
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  unFocusGlobal();
                                  setState(() => _acceptMarketing = !_acceptMarketing);
                                },
                                child: Text(S.current.registerMarketingConsentAccept),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitRegister,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(S.current.signUp),
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
