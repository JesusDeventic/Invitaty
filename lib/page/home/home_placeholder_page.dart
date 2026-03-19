import 'dart:io';

import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/page/home/placeholder_section_page.dart';
import 'package:filmoly/page/users/account_profile_page.dart';
import 'package:filmoly/page/users/contact_page.dart';
import 'package:filmoly/page/users/general_settings_page.dart';
import 'package:filmoly/page/users/faq_page.dart';
import 'package:filmoly/routes/app_routes.dart';
import 'package:filmoly/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePlaceholderPage extends StatefulWidget {
  const HomePlaceholderPage({super.key});

  @override
  State<HomePlaceholderPage> createState() => _HomePlaceholderPageState();
}

class _HomePlaceholderPageState extends State<HomePlaceholderPage> {
  int _unreadNotificationsCount = 0;
  int _unreadMessagesCount = 0;
  bool _collapseMenu = false;

  Widget _buildDesktopAppBarDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).colorScheme.outline,
    );
  }

  Widget _buildPrivateChatsButton() {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Tooltip(
      message: S.current.privateMessages,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceholderSectionPage(
                title: S.current.privateMessages,
              ),
            ),
          );
        },
        child: Padding(
          padding: isDesktop ? const EdgeInsets.all(8) : const EdgeInsets.all(2),
          child: Container(
            width: isDesktop ? null : 50,
            height: 50,
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  _unreadMessagesCount > 0
                      ? Icons.mail_rounded
                      : Icons.mail_outline_rounded,
                  color: _unreadMessagesCount > 0
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSurface,
                  size: 34,
                ),
                if (_unreadMessagesCount > 0)
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
                        _unreadMessagesCount > 9
                            ? '9+'
                            : _unreadMessagesCount.toString(),
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

  Widget _buildNotificationIcon() {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Tooltip(
      message: S.current.notificationsLabel,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceholderSectionPage(
                title: S.current.notificationsLabel,
              ),
            ),
          );
        },
        child: Padding(
          padding: isDesktop ? const EdgeInsets.all(8) : const EdgeInsets.all(2),
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
            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
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
                    onTap: () {
                      Navigator.pop(dialogContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountProfilePage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    mouseCursor: SystemMouseCursors.click,
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
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                S.current.showMyProfile,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.8),
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
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
                  leading: const Icon(Icons.settings_applications_rounded),
                  title: Text(S.current.generalSettings),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GeneralSettingsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: Text(S.current.accountAndProfile),
                  onTap: () {
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
                      MaterialPageRoute(
                        builder: (context) => FAQPage(),
                      ),
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
                ListTile(
                  leading: const Icon(Icons.exit_to_app_rounded),
                  title: Text(S.current.userSectionSessionClose),
                  onTap: () {
                    final router = GoRouter.of(context);
                    showDialog(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: Text(S.current.userSectionSessionClose),
                        content: Text(S.current.dialogCloseSessionContent),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(c),
                                  child: Text(S.current.actionNo),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () async {
                                    Navigator.pop(c);
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
                                              child: const CircularProgressIndicator(strokeWidth: 2),
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
                                  },
                                  child: Text(S.current.actionYes),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel_presentation_rounded),
                  title: Text(S.current.dialogCloseAppTitle),
                  onTap: () {
                    Navigator.pop(dialogContext);
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

  void _showExitAppDialog() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(S.current.dialogCloseAppTitle),
        content: Text('${S.current.dialogCloseAppTitle}?'),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(c),
                  child: Text(S.current.actionNo),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(c);
                    exit(0);
                  },
                  child: Text(S.current.actionYes),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
          padding: isDesktop ? const EdgeInsets.all(8) : const EdgeInsets.all(2),
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
                      globalCurrentUser.username,
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        titleSpacing: isDesktop ? 16 : 8,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactPage(),
              ),
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
                  errorBuilder: (_, __, ___) => const Icon(Icons.movie, size: 40),
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
          _buildPrivateChatsButton(),
          if (isDesktop) _buildDesktopAppBarDivider(),
          _buildNotificationIcon(),
          if (isDesktop) _buildDesktopAppBarDivider(),
          _buildUserProfile(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 0.5,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
          ),
        ),
      ),
      body: SafeArea(
        child: isDesktop ? _buildDesktopBody() : _buildMobileBody(),
      ),
    );
  }

  Widget _buildDesktopBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSidebar(),
        Expanded(
          child: _buildMainContent(),
        ),
      ],
    );
  }

  Widget _buildMobileBody() {
    return _buildMainContent();
  }

  Widget _buildSidebar() {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _collapseMenu ? 70 : 250,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          color: theme.colorScheme.primary,
          surfaceTintColor: theme.colorScheme.primary,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: 48,
                      child: ListTile(
                        selected: true,
                        selectedTileColor: Colors.transparent,
                        selectedColor: theme.colorScheme.secondary,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        visualDensity: VisualDensity.standard,
                        minVerticalPadding: 0,
                        title: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: _collapseMenu ? 0.0 : 1.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.home_rounded,
                                    color: theme.colorScheme.secondary,
                                    size: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      S.current.menuHome,
                                      style: TextStyle(
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: _collapseMenu ? 1.0 : 0.0,
                              child: Icon(
                                Icons.home_rounded,
                                color: theme.colorScheme.secondary,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              SizedBox(
                height: 40,
                child: Tooltip(
                  message: _collapseMenu
                      ? S.current.expandMenu
                      : S.current.collapseMenu,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      unFocusGlobal();
                      setState(() => _collapseMenu = !_collapseMenu);
                    },
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: _collapseMenu
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Center(
                        child: Icon(
                          Icons.chevron_right,
                          color: theme.colorScheme.onPrimary,
                          size: 20,
                        ),
                      ),
                      secondChild: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: theme.colorScheme.onPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              S.current.collapseMenu,
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      layoutBuilder: (topChild, topKey, bottomChild, bottomKey) {
                        return Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned.fill(key: bottomKey, child: bottomChild),
                            Positioned.fill(key: topKey, child: topChild),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${S.current.welcome}, ${globalCurrentUser.displayName.isNotEmpty ? globalCurrentUser.displayName : globalCurrentUser.username}',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            S.current.appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
