import 'dart:typed_data';

import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/core/api_error_messages.dart';
import 'package:filmaniak/core/user_preferences.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/core/global_variables.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/user_model.dart';
import 'package:filmaniak/routes/app_routes.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AccountProfilePage extends StatefulWidget {
  const AccountProfilePage({super.key});

  @override
  State<AccountProfilePage> createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _avatarUrl;
  Uint8List? _newAvatarBytes;
  String _newAvatarFilename = 'avatar.jpg';
  bool _deleteAvatarRequested = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  String? _countryCode;
  bool _marketingConsent = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  void _loadFields() {
    final u = globalCurrentUser;
    _avatarUrl = u.avatarUrl;
    _newAvatarBytes = null;
    _usernameController.text = u.username;
    _displayNameController.text = u.displayName;
    _emailController.text = u.email;
    _descriptionController.text = u.description;
    _websiteController.text = u.websiteUrl;
    _birthdateController.text = u.birthdate;
    _countryCode = u.country.isNotEmpty ? u.country : null;
    _marketingConsent = u.marketingConsent;
    _deleteAvatarRequested = false;
    _updateCountryDisplayName();
    setState(() {});
  }

  void _updateCountryDisplayName() {
    if (_countryCode != null) {
      try {
        final country = Country.parse(_countryCode!);
        _countryController.text = country.displayNameNoCountryCode;
      } catch (_) {
        _countryController.text = '';
      }
    } else {
      _countryController.text = '';
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    _websiteController.dispose();
    _countryController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isEditing,
      onPopInvokedWithResult: (didPop, result) async {
        if (_isEditing && !didPop) {
          await _confirmChangesDialog();
          // Siempre salir tras el diálogo (como Fitcron)
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.userSectionAccount),
          actions: [
            if (!_isEditing)
              IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: () => setState(() => _isEditing = true),
              ),
            if (_isEditing)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () async {
                      final result = await _confirmChangesDialog();
                      if (result['saved'] == false) _loadFields();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_rounded),
                    onPressed: _saveUser,
                  ),
                ],
              ),
            const SizedBox(width: 8),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, bool>> _confirmChangesDialog() async {
    final result = await showDialog<Map<String, bool>>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(S.current.dialogWarningTitle),
          content: Text(S.current.dialogConfirmSave),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop({'saved': false, 'success': false});
                      setState(() => _isEditing = false);
                      _loadFields();
                    },
                    child: Text(S.current.actionNo),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final ok = await _saveUser();
                      if (ctx.mounted) Navigator.of(ctx).pop({'saved': true, 'success': ok});
                    },
                    child: Text(S.current.actionYes),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return result ?? {'saved': false, 'success': false};
  }

  Future<bool> _saveUser() async {
    if (!_formKey.currentState!.validate()) {
      showCustomSnackBar(S.current.messageGeneralError, type: -1);
      return false;
    }
    _formKey.currentState!.save();

    final navigator = Navigator.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const PopScope(
        canPop: false,
        child: Center(child: CircularProgressIndicator()),
      ),
    );

    final result = await FilmaniakApi.updateUser(
      userEmail: _emailController.text.trim(),
      websiteUrl: _websiteController.text.trim(),
      displayName: _displayNameController.text.trim().isEmpty ? null : _displayNameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
      // Envío string vacío para poder "borrar" valores.
      country: _countryCode ?? '',
      birthdate: _birthdateController.text.trim().isEmpty ? '' : _birthdateController.text.trim(),
      marketingConsent: _marketingConsent,
      deleteAvatar: _deleteAvatarRequested,
      avatarBytes: _newAvatarBytes,
      avatarFilename: _newAvatarFilename,
    );

    navigator.pop();

    if (result['success'] == true) {
      final userJson = result['user'];
      if (userJson is Map<String, dynamic>) {
        globalCurrentUser = FilmaniakUser.fromJson(userJson);
        await UserPreferences().setCachedUser(globalCurrentUser);
      }
      showCustomSnackBar(S.current.messageUpdateSuccess, type: 1);
      setState(() {
        _isEditing = false;
        _loadFields();
      });
      return true;
    } else {
      final code = result['code'] as String?;
      showCustomSnackBar(getAuthErrorMessage(code), type: -1);
      return false;
    }
  }

  Widget _buildForm() {
    Widget avatarWidget;
    if (_newAvatarBytes != null && _newAvatarBytes!.isNotEmpty) {
      avatarWidget = ClipOval(
        child: Image.memory(
          _newAvatarBytes!,
          fit: BoxFit.cover,
          width: 120,
          height: 120,
        ),
      );
    } else {
      avatarWidget = userAvatar(
        context,
        avatarUrl: _deleteAvatarRequested ? '' : (_avatarUrl ?? ''),
        username: globalCurrentUser.username,
        size: 120,
      );
    }

    final hasExistingAvatar = (_avatarUrl ?? '').contains('avatars');
    final canDeleteAvatar = _isEditing &&
        hasExistingAvatar &&
        !_deleteAvatarRequested &&
        _newAvatarBytes == null;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(S.current.userAvatar),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: _isEditing ? _pickAvatar : null,
                    child: Stack(
                      children: [
                        Container(
                          decoration: _isEditing
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 5.0,
                                  ),
                                  borderRadius: BorderRadius.circular(100.0),
                                )
                              : null,
                          width: 120,
                          height: 120,
                          child: avatarWidget,
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Icon(Icons.edit_rounded, color: Colors.white, size: 16),
                            ),
                          ),
                        // Botón X para borrar avatar (como Fitcron)
                        if (canDeleteAvatar)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                unFocusGlobal();
                                setState(() {
                                  _deleteAvatarRequested = true;
                                  _newAvatarBytes = null;
                                });
                              },
                              child: Tooltip(
                                message: S.current.buttonDeleteAvatar,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.secondary,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      enabled: false,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_rounded),
                        labelText: S.current.username,
                      ),
                    ),
                    const SizedBox(height: 8),
                    /*
                    // Ocultamos el campo "Nombre para mostrar" (sin borrarlo).
                    // Se mantiene el controller y el guardado por si luego lo reactivamos.
                    TextFormField(
                      enabled: _isEditing,
                      controller: _displayNameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.badge_rounded),
                        labelText: S.current.textfieldDisplayNameLabel,
                      ),
                    ),
                    */
                    const SizedBox(height: 8),
                    TextFormField(
                      enabled: _isEditing,
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_rounded),
                        labelText: S.current.userEmail,
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return S.current.textfieldMailEmpty;
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(v)) {
                          return S.current.textfieldMailError;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          TextFormField(
            enabled: _isEditing,
            minLines: 1,
            maxLines: 5,
            maxLength: 500,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.description_rounded),
              labelText: S.current.userDescription,
            ),
            controller: _descriptionController,
          ),
          const SizedBox(height: 8),


          TextFormField(
            enabled: _isEditing,
            controller: _websiteController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.link_rounded),
              labelText: S.current.webBlogLabel,
              hintText: S.current.webBlogHint,
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),

          TextFormField(
            enabled: _isEditing,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.public_rounded),
              labelText: S.current.textfieldUserCountryLabel,
              suffixIcon: _countryCode != null
                  ? _isEditing
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Country.parse(_countryCode!).flagEmoji,
                              style: const TextStyle(fontSize: 24),
                            ),
                            IconButton(
                              tooltip: S.current.removeCountryTooltip,
                              icon: const Icon(Icons.close_rounded, size: 20),
                              onPressed: () {
                                setState(() {
                                  _countryCode = null;
                                  _countryController.text = '';
                                });
                              },
                            ),
                          ],
                        )
                      : Text(
                          Country.parse(_countryCode!).flagEmoji,
                          style: const TextStyle(fontSize: 24),
                        )
                  : null,
            ),
            controller: _countryController,
            readOnly: true,
            onTap: _isEditing
                ? () {
                    showCountryPicker(
                      context: context,
                      favorite: _countryCode != null ? [_countryCode!] : [],
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        setState(() {
                          _countryCode = country.countryCode;
                          _countryController.text = country.displayNameNoCountryCode;
                        });
                      },
                    );
                  }
                : null,
          ),
          const SizedBox(height: 16),

          

          TextFormField(
            enabled: _isEditing,
            style: const TextStyle(color: Colors.transparent),
            decoration: InputDecoration(
              labelText: S.current.textfieldUserBirthdayLabel,
              prefixIcon: const Icon(Icons.cake_rounded),
              prefixText: formatDate(_birthdateController.text),
              suffixIcon: _isEditing && _birthdateController.text.trim().isNotEmpty
                  ? IconButton(
                      tooltip: S.current.removeBirthdateTooltip,
                      icon: const Icon(Icons.close_rounded, size: 20),
                      onPressed: () {
                        setState(() {
                          _birthdateController.text = '';
                        });
                      },
                    )
                  : null,
              suffixText: _birthdateController.text.isEmpty
                  ? ''
                  : '${formatAgeFromBirthday(
                    formatDate(_birthdateController.text),
                    inputFormat: globalCurrentUser.dateFormat,
                  )} ${S.current.userYears}',
            ),
            controller: _birthdateController,
            readOnly: true,
            onTap: _isEditing
                ? () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime(DateTime.now().year - 25),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(DateTime.now().year - 14),
                    );
                    if (selected != null) {
                      setState(() {
                        _birthdateController.text =
                            '${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}';
                      });
                    }
                  }
                : null,
          ),
          const SizedBox(height: 16),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _marketingConsent,
            onChanged: _isEditing
                ? (v) => setState(() => _marketingConsent = v)
                : null,
            title: Text(S.current.registerMarketingConsentAccept, style: const TextStyle(fontSize: 14)),          
          ),
          if (!_isEditing) ...[
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: _showChangePasswordDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline_rounded),
                const SizedBox(width: 10),
                Text(S.current.buttonChangePassword),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.error),
            ),
            onPressed: _showDeleteAccountDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delete_rounded),
                const SizedBox(width: 10),
                Text(S.current.buttonDeleteAccount),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Future<void> _pickAvatar() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.single;
        if (file.bytes != null && file.bytes!.isNotEmpty) {
          setState(() {
            _newAvatarBytes = file.bytes;
            _newAvatarFilename = file.name.isNotEmpty ? file.name : 'avatar.jpg';
          });
        } else {
          showCustomSnackBar(S.current.errorProcessingImage, type: -1);
        }
      }
    } catch (e) {
      showCustomSnackBar(S.current.errorProcessingImage, type: -1);
    }
  }

  void _showChangePasswordDialog() {
    final currentPwdController = TextEditingController();
    final newPwdController = TextEditingController();
    final confirmPwdController = TextEditingController();
    final newPwdFocus = FocusNode();
    final confirmPwdFocus = FocusNode();
    bool obscureCurrent = true;
    bool obscureNew = true;

    final screenWidth = MediaQuery.of(context).size.width;
    final dialogHInset = ((screenWidth - 800) / 2).clamp(16.0, double.infinity);

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setStateDialog) => AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: dialogHInset, vertical: 24),
          title: Text(S.current.buttonChangePassword),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              TextField(
                controller: currentPwdController,
                obscureText: obscureCurrent,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => newPwdFocus.requestFocus(),
                decoration: InputDecoration(
                  labelText: S.current.currentPassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(obscureCurrent ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setStateDialog(() => obscureCurrent = !obscureCurrent),
                  ),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newPwdController,
                focusNode: newPwdFocus,
                obscureText: obscureNew,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => confirmPwdFocus.requestFocus(),
                decoration: InputDecoration(
                  labelText: S.current.newPassword,
                  prefixIcon: const Icon(Icons.lock_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(obscureNew ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setStateDialog(() => obscureNew = !obscureNew),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmPwdController,
                focusNode: confirmPwdFocus,
                obscureText: obscureNew,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: S.current.confirmPassword,
                  prefixIcon: const Icon(Icons.lock_rounded),
                ),
              ),
            ],
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(S.current.buttonCancel),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final current = currentPwdController.text;
                      final newPwd = newPwdController.text;
                      final confirm = confirmPwdController.text;

                      if (current.isEmpty || newPwd.isEmpty || confirm.isEmpty) {
                        showCustomSnackBar(S.current.errorAuthMissingFields, type: -1);
                        return;
                      }
                      if (newPwd.length < 6) {
                        showCustomSnackBar(S.current.errorAuthInvalidPassword, type: -1);
                        return;
                      }
                      if (newPwd != confirm) {
                        showCustomSnackBar(S.current.passwordMismatch, type: -1);
                        return;
                      }

                      Navigator.of(ctx).pop();
                      final navigator = Navigator.of(context);

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const PopScope(
                          canPop: false,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );

                      final result = await FilmaniakApi.changePassword(
                        currentPassword: current,
                        newPassword: newPwd,
                      );

                      navigator.pop();

                      if (result['success'] == true) {
                        showCustomSnackBar(S.current.passwordChanged, type: 1);
                      } else {
                        showCustomSnackBar(getAuthErrorMessage(result['code'] as String?), type: -1);
                      }
                    },
                    child: Text(S.current.buttonConfirm),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final passwordController = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogHInset = ((screenWidth - 800) / 2).clamp(16.0, double.infinity);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: dialogHInset, vertical: 24),
          title: Text(S.current.buttonDeleteAccount),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Text(
                S.current.dialogDeleteAccount,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: S.current.dialogDeleteAccountPassword,
                  prefixIcon: const Icon(Icons.lock_rounded),
                ),
                autofocus: true,
              ),
            ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(S.current.buttonCancel),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.error),
                    ),
                    onPressed: () async {
                      final pwd = passwordController.text;
                      if (pwd.isEmpty) {
                        showCustomSnackBar(S.current.fieldRequired, type: -1);
                        return;
                      }
                      Navigator.of(ctx).pop();

                      final navigator = Navigator.of(context);
                      final router = GoRouter.of(context);

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const PopScope(
                          canPop: false,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );

                      final result = await FilmaniakApi.deleteAccount(pwd);

                      navigator.pop();

                      if (result['success'] == true) {
                        showCustomSnackBar(S.current.messageDeleteAccountSuccess, type: 1);
                        await logoutUser();
                        router.go(AppRoutes.login);
                      } else {
                        final code = result['code'] as String?;
                        showCustomSnackBar(getAuthErrorMessage(code), type: -1);
                      }
                    },
                    child: Text(S.current.buttonConfirm),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}
