import 'dart:async';
import 'dart:io';
import 'package:invitaty/api/invitaty_api.dart';
import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/core/global_variables.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/page/users/account_profile_page.dart';
import 'package:invitaty/page/users/contact_page.dart';
import 'package:invitaty/page/users/general_settings_page.dart';
import 'package:invitaty/page/users/faq_page.dart';
import 'package:invitaty/page/users/notifications_page.dart';
import 'package:invitaty/routes/app_routes.dart';
import 'package:invitaty/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/providers/invitation_provider.dart';
import 'package:invitaty/data/invitation_mock.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _unreadNotificationsCount = 0;
  Timer? _unreadTimer;
  bool get _isGuest => globalUserToken.isEmpty;
  String get _userLabel => globalCurrentUser.username.isNotEmpty
      ? globalCurrentUser.username
      : 'Invitado';

  void _showAuthRequiredSnackbar() {
    showCustomSnackBar(
      S.current.authRequiredFunctionMessage,
      type: -1,
      goToLogin: true,
      onGoToLogin: () => context.go(AppRoutes.login),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshUnreadNotifications();
    _unreadTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      _refreshUnreadNotifications();
    });
  }

  @override
  void dispose() {
    _unreadTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshUnreadNotifications() async {
    if (_isGuest) {
      if (mounted) setState(() => _unreadNotificationsCount = 0);
      return;
    }
    final count = await InvitatyApi.getUnreadNotificationsCount();
    if (mounted) setState(() => _unreadNotificationsCount = count);
  }

  Widget _buildDesktopAppBarDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).colorScheme.outline,
    );
  }

  Widget _buildNotificationIcon() {
    if (_isGuest) return const SizedBox.shrink();
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Tooltip(
      message: S.current.notificationsLabel,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsPage()),
          ).then((_) => _refreshUnreadNotifications());
        },
        child: Padding(
          padding: isDesktop
              ? const EdgeInsets.all(8)
              : const EdgeInsets.all(2),
          child: Container(
            width: isDesktop ? null : 50,
            height: 50,
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  _unreadNotificationsCount > 0
                      ? Icons.notifications_active
                      : Icons.notifications,
                  color: _unreadNotificationsCount > 0
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSurface,
                  size: 34,
                ),
                if (_unreadNotificationsCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        _unreadNotificationsCount > 9
                            ? '9+'
                            : _unreadNotificationsCount.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openUserPanel() {
    unFocusGlobal();
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final width = isDesktop
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.85;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: width,
          height: MediaQuery.of(context).size.height,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: Container(color: Colors.transparent),
                  ),
                  Transform.translate(
                    offset: Offset(width * (1 - value), 0),
                    child: child,
                  ),
                ],
              );
            },
            child: _buildSettingsPanel(ctx),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsPanel(BuildContext dialogContext) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(-1, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    // Menú sin acceso al perfil público en esta app.
                    onTap: null,
                    borderRadius: BorderRadius.circular(8),
                    mouseCursor: SystemMouseCursors.basic,
                    child: Row(
                      children: [
                        userAvatar(
                          context,
                          avatarUrl: globalCurrentUser.avatarUrl,
                          username: globalCurrentUser.username,
                          size: 40,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                globalCurrentUser.displayName.isNotEmpty
                                    ? globalCurrentUser.displayName
                                    : globalCurrentUser.username,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Tooltip(
                  message: S.current.buttonClose,
                  child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                rowSettingsAppAndVersion(context),
                const SizedBox(height: 4),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.app_settings_alt_rounded,
                    color: _isGuest
                        ? Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5)
                        : null,
                  ),
                  title: Text(
                    S.current.generalSettings,
                    style: TextStyle(
                      color: _isGuest
                          ? Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5)
                          : null,
                    ),
                  ),
                  onTap: () {
                    if (_isGuest) {
                      Navigator.of(dialogContext).pop();
                      _showAuthRequiredSnackbar();
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GeneralSettingsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.person_rounded,
                    color: _isGuest
                        ? Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.45)
                        : null,
                  ),
                  title: Text(
                    S.current.accountSettings,
                    style: _isGuest
                        ? TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.45),
                          )
                        : null,
                  ),
                  onTap: () {
                    if (_isGuest) {
                      Navigator.of(dialogContext).pop();
                      _showAuthRequiredSnackbar();
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountProfilePage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help_outline_rounded),
                  title: Text(S.current.userSectionFAQs),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.support_agent_rounded),
                  title: Text(S.current.userSectionContact),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactPage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                if (!_isGuest)
                  ListTile(
                    leading: const Icon(Icons.exit_to_app_rounded),
                    title: Text(S.current.userSectionSessionClose),
                    onTap: () {
                      final router = GoRouter.of(context);
                      showConfirmDialogGlobal(
                        context,
                        title: S.current.userSectionSessionClose,
                        message: S.current.dialogCloseSessionContent,
                      ).then((confirmed) async {
                        if (!confirmed) return;
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          barrierColor: Colors.black26,
                          builder: (ctx) => PopScope(
                            canPop: false,
                            child: Dialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              child: SizedBox.expand(
                                child: Center(
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                        await logoutUser();
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                        router.go(AppRoutes.login);
                      });
                    },
                  ),
                if (_isGuest)
                  ListTile(
                    leading: const Icon(Icons.login_rounded),
                    title: Text(S.current.signIn),
                    onTap: () => context.go(AppRoutes.login),
                  ),
                ListTile(
                  leading: const Icon(Icons.cancel_presentation_rounded),
                  title: Text(S.current.dialogCloseAppTitle),
                  onTap: () {
                    _showExitAppDialog();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showExitAppDialog() async {
    final confirmed = await showConfirmDialogGlobal(
      context,
      title: S.current.dialogCloseAppTitle,
      message: S.current.dialogCloseAppContent,
      destructive: true,
    );
    if (confirmed) exit(0);
  }

  Widget _buildUserProfile() {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Tooltip(
      message: S.current.settingsLabel,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        mouseCursor: SystemMouseCursors.click,
        onTap: _openUserPanel,
        child: Padding(
          padding: isDesktop
              ? const EdgeInsets.all(8)
              : const EdgeInsets.all(2),
          child: Container(
            width: isDesktop ? null : 50,
            height: 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                userAvatar(
                  context,
                  avatarUrl: globalCurrentUser.avatarUrl,
                  username: globalCurrentUser.username,
                  size: 40,
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      _userLabel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _showExitAppDialog();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          titleSpacing: isDesktop ? 16 : 8,
          title: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactPage()),
              );
            },
            borderRadius: BorderRadius.circular(8),
            mouseCursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 50,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.movie, size: 40),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      S.current.appName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isDesktop ? 30 : 22,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            _buildNotificationIcon(),
            if (isDesktop && !_isGuest) _buildDesktopAppBarDivider(),
            _buildUserProfile(),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 0.5,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.2),
            ),
          ),
        ),
        body: SafeArea(child: _buildMainContent()),
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          emptyDataWidget(
            context,
            Icons.event_note_rounded,
            S.current.homeEmptyInvitationsTitle,
            S.current.homeEmptyInvitationsSubtitle,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              /*if (_isGuest) {
                _showAuthRequiredSnackbar();
                return;
              }*/
              final invitationProvider = context.read<InvitationProvider>();

              invitationProvider.setInvitation(invitationMock);

              context.push(AppRoutes.editor);
            },
            icon: const Icon(Icons.add_rounded),
            label: Text(S.current.homeCreateInvitationButton),
          ),
        ],
      ),
    );
  }
}
