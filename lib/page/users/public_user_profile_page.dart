import 'package:filmaniak/api/filmaniak_api.dart';
import 'package:filmaniak/core/global_functions.dart';
import 'package:filmaniak/core/global_variables.dart';
import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/model/user_model.dart';
import 'package:filmaniak/page/messages/private_chat_page.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class PublicUserProfilePage extends StatefulWidget {
  const PublicUserProfilePage({
    super.key,
    required this.username,
    this.initialUser,
  });

  final String username;
  final FilmaniakUser? initialUser;

  @override
  State<PublicUserProfilePage> createState() => _PublicUserProfilePageState();
}

class _PublicUserProfilePageState extends State<PublicUserProfilePage> {
  FilmaniakUser? _user;
  bool _isLoading = false;

  Future<void> _showShareOptions(String link, FilmaniakUser user) async {
    if (link.isEmpty) return;
    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.copy_rounded),
                title: Text(S.current.copyProfileLink),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  await Clipboard.setData(ClipboardData(text: link));
                  showCustomSnackBar(S.current.copiedProfileLinkSnackbar, type: 1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_rounded),
                title: Text(S.current.showQrOption),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  await showDialog<void>(
                    context: context,
                    builder: (dCtx) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                S.current.qrTitle(user.username),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: 240,
                                height: 240,
                                child: QrImageView(
                                  data: link,
                                  version: QrVersions.auto,
                                  size: 240,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => Navigator.of(dCtx).pop(),
                                child: Text(S.current.close),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share_rounded),
                title: Text(S.current.shareOption),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  await SharePlus.instance.share(
                    ShareParams(
                      text: link,
                      subject: S.current.profileShareSubject(user.username),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _user = widget.initialUser;
    _isLoading = _user == null;
    _loadUser();
  }

  Future<void> _loadUser() async {
    if (_user == null) {
      setState(() => _isLoading = true);
    }
    final user = await FilmaniakApi.getPublicUserByUsername(widget.username);
    if (!mounted) return;
    setState(() {
      _user = user ?? _user;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(S.current.publicProfileAppBarTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_off_rounded, size: 56),
                const SizedBox(height: 12),
                Text(
                  S.current.userNotFoundPublicProfileText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _loadUser,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(S.current.retryPublicProfile),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final user = _user!;
    final publicUrl = FilmaniakApi.buildPublicProfileUrl(user.username);
    final website = user.websiteUrl.trim();
    final fullName = [user.firstName, user.lastName]
        .where((e) => e.trim().isNotEmpty)
        .join(' ')
        .trim();

    final lastLoginText = user.lastLogin.isNotEmpty
        ? _formatDateForUser(user.lastLogin, user.dateFormat)
        : '';

    final countryFlag = _tryCountryFlag(user.country);
    final ageLine = user.birthdate.isNotEmpty
        ? '${formatAgeFromBirthday(user.birthdate)} ${S.current.userYears}'
        : '';

    return Scaffold(
      appBar: AppBar(
        title: Text('@${user.username}'),
        actions: [
          if (user.id != globalCurrentUser.id)
            IconButton(
              tooltip: S.current.sendMessageTooltip,
              icon: const Icon(Icons.mail_outline_rounded),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PrivateChatPage(
                    recipientId: user.id,
                    recipientUsername: user.username,
                    recipientAvatarUrl: user.avatarUrl,
                  ),
                ),
              ),
            ),
          IconButton(
            tooltip: S.current.shareTooltip,
            onPressed: publicUrl.isEmpty
                ? null
                : () => _showShareOptions(publicUrl, user),
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadUser,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          children: [
            // Header tipo Letterboxd: avatar + nombre + detalles compactos.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatarWidget(
                  user.avatarUrl,
                  context,
                  user.username,
                  size: 80,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              user.displayName.isNotEmpty
                                  ? user.displayName 
                                  : user.username ,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (countryFlag.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 0),
                              child: Text(
                                countryFlag,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      if (ageLine.isNotEmpty)
                        Text(
                          ageLine,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      if (lastLoginText.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${S.current.lastAccessChipPrefix}: $lastLoginText',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      if (fullName.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          fullName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      // (Mantenemos el perfil simple: país como bandera, edad y último acceso como líneas.)
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),
            if (user.description.trim().isNotEmpty) ...[
              Text(
                S.current.bioLabel,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Html(
                data: user.description.trim(),
                style: {
                  'body': Style(
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    fontSize: FontSize(14),
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  'a': Style(
                    color: Theme.of(context).colorScheme.primary,
                    textDecoration: TextDecoration.underline,
                  ),
                },
                onLinkTap: (url, _, __) async {
                  final uri = Uri.tryParse(url ?? '');
                  if (uri == null) return;
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                },
              ),
              const SizedBox(height: 18),
            ],

            if (website.isNotEmpty) ...[
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final uri = Uri.tryParse(website);
                  if (uri == null) return;
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.public_rounded,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.current.webBlogLabel,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              website,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.open_in_new_rounded),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],

            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  String _formatDateForUser(String input, String dateFormat) {
    try {
      final normalized = input.replaceAll(' ', 'T');
      final dt = DateTime.tryParse(normalized);
      if (dt == null) return input;
      if (dateFormat.trim().isEmpty) return input;
      return DateFormat(dateFormat).format(dt);
    } catch (_) {
      return input;
    }
  }

  String _tryCountryFlag(String countryCode) {
    if (countryCode.trim().isEmpty) return '';
    try {
      return Country.parse(countryCode).flagEmoji;
    } catch (_) {
      return '';
    }
  }
}
