import 'dart:typed_data';

import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filmoly/api/filmoly_api.dart';
import 'package:filmoly/core/api_error_messages.dart';
import 'package:filmoly/core/user_preferences.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/model/user_model.dart';
import 'package:filmoly/routes/app_routes.dart';
import 'package:filmoly/widget/components_widgets.dart';
import 'package:flutter/material.dart';
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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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
    _birthdateController.text = u.birthdate;
    _countryCode = u.country.isNotEmpty ? u.country : null;
    _marketingConsent = u.marketingConsent;
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

    final result = await FilmolyApi.updateUser(
      userEmail: _emailController.text.trim(),
      displayName: _displayNameController.text.trim().isEmpty ? null : _displayNameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
      country: _countryCode,
      birthdate: _birthdateController.text.trim().isEmpty ? null : _birthdateController.text.trim(),
      marketingConsent: _marketingConsent,
      deleteAvatar: false,
      avatarBytes: _newAvatarBytes,
      avatarFilename: _newAvatarFilename,
    );

    navigator.pop();

    if (result['success'] == true) {
      final userJson = result['user'];
      if (userJson is Map<String, dynamic>) {
        globalCurrentUser = FilmolyUser.fromJson(userJson);
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
        avatarUrl: _avatarUrl ?? '',
        username: globalCurrentUser.username,
        size: 120,
      );
    }

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
                    TextFormField(
                      enabled: _isEditing,
                      controller: _displayNameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.badge_rounded),
                        labelText: S.current.textfieldDisplayNameLabel,
                      ),
                    ),
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
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.public_rounded),
              labelText: S.current.textfieldUserCountryLabel,
              suffixIcon: _countryCode != null
                  ? Text(Country.parse(_countryCode!).flagEmoji, style: const TextStyle(fontSize: 24))
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
            style: const TextStyle(color: Colors.transparent),
            decoration: InputDecoration(
              labelText: S.current.textfieldUserBirthdayLabel,
              prefixIcon: const Icon(Icons.cake_rounded),
              prefixText: formatDate(_birthdateController.text),
              suffixText: _birthdateController.text.isEmpty
                  ? ''
                  : '${formatAgeFromBirthday(_birthdateController.text, inputFormat: globalCurrentUser.dateFormat)} ${S.current.userYears}',
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
          const SizedBox(height: 8),

          if (_isEditing) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
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
            ),
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

  void _showDeleteAccountDialog() {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(S.current.buttonDeleteAccount),
          content: Column(
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
                        showCustomSnackBar(S.current.errorAuthInvalidPassword, type: -1);
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

                      final result = await FilmolyApi.deleteAccount(pwd);

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
      ),
    );
  }
}
