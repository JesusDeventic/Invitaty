import 'package:filmaniak/generated/l10n.dart';
import 'package:filmaniak/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

/// Página de contacto/soporte (misma estructura que Fitcron UserSettingsSupport).
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.userSectionContact),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isDesktop
                ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Panel izquierdo - Contacto
                    Expanded(
                      flex: 1,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkResponse(
                                onTap: () async {
                                  const url = 'https://deventic.com';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url),
                                        mode: LaunchMode.externalApplication);
                                  } else {
                                    showCustomSnackBar(
                                        S.current.socialWebError, type: -1);
                                  }
                                },
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                    'assets/logo.png',
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.movie, size: 64),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'filmaniak.com',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                S.current.userSectionContact,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                S.current.textUserSupportDescription,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 32),
                              _contactButtons(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Panel derecho - solo botones legales (ocultamos RRSS de momento)
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [_privacyButtons(context)],
                      ),
                    ),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkResponse(
                              onTap: () async {
                                const url = 'https://deventic.com';
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url),
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  showCustomSnackBar(
                                      S.current.socialWebError, type: -1);
                                }
                              },
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(
                                  'assets/logo.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.movie, size: 48),
                                ),
                              ),
                            ),
                            Text(
                              'filmaniak.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.current.userSectionContact,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              S.current.textUserSupportDescription,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _contactButtons(context),
                          ],
                        ),
                      ),
                    ),
                    // RRSS ocultas de momento
                    const SizedBox(height: 8),
                    _privacyButtons(context),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  Widget _contactButtons(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        _contactButton(
          context: context,
          icon: SvgPicture.asset(
            'assets/svg/email.svg',
            color: Colors.indigo,
            height: 40,
            fit: BoxFit.contain,
          ),
          color: Colors.indigo,
          label: S.current.socialMailLabel,
          onTap: () async {
            final subject = S.current.subjectSupport;
            final uri = Uri(
              scheme: 'mailto',
              path: 'info@deventic.com',
              queryParameters: {'subject': subject},
            );
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              showCustomSnackBar(S.current.socialWebError, type: -1);
            }
          },
        ),
        _contactButton(
          context: context,
          icon: SvgPicture.asset(
            'assets/svg/whatsapp.svg',
            color: Colors.green,
            fit: BoxFit.contain,
            height: 40,
          ),
          color: Colors.green,
          label: S.current.socialWhatsappLabel,
          onTap: () async {
            try {
              const whatsappUrl = 'whatsapp://send?phone=+34611151880';
              final whatsappUri = Uri.parse(whatsappUrl);
              if (await canLaunchUrl(whatsappUri)) {
                await launchUrl(whatsappUri);
              } else {
                const webUrl = 'https://wa.me/34611151880';
                final webUri = Uri.parse(webUrl);
                if (await canLaunchUrl(webUri)) {
                  await launchUrl(webUri, mode: LaunchMode.externalApplication);
                } else {
                  showCustomSnackBar(S.current.socialWhatsappError, type: -1);
                }
              }
            } catch (_) {
              showCustomSnackBar(S.current.socialWhatsappError, type: -1);
            }
          },
        ),
        _contactButton(
          context: context,
          icon: SvgPicture.asset(
            'assets/svg/telegram.svg',
            color: Colors.lightBlueAccent,
            height: 40,
            fit: BoxFit.contain,
          ),
          color: Colors.lightBlueAccent,
          label: S.current.socialTelegramLabel,
          onTap: () async {
            try {
              const telegramUrl = 'tg://resolve?domain=deventic';
              final telegramUri = Uri.parse(telegramUrl);

              if (await canLaunchUrl(telegramUri)) {
                await launchUrl(telegramUri);
              } else {
                const webUrl = 'https://t.me/deventic';
                final webUri = Uri.parse(webUrl);

                if (await canLaunchUrl(webUri)) {
                  await launchUrl(webUri, mode: LaunchMode.externalApplication);
                } else {
                  showCustomSnackBar(S.current.socialWebError, type: -1);
                }
              }
            } catch (_) {
              showCustomSnackBar(S.current.socialWebError, type: -1);
            }
          },
        ),
      ],
    );
  }

  Widget _contactButton({
    required BuildContext context,
    required Widget icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.5), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _privacyButtons(BuildContext context) {
    const baseUrl = 'https://deventic.com';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              final url = Uri.parse('$baseUrl/privacy-policy/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                showCustomSnackBar(S.current.socialWebError, type: -1);
              }
            },
            icon: const Icon(Icons.privacy_tip_rounded),
            label: Text(S.current.privacyPoliciesLabel),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              final url = Uri.parse('$baseUrl/terms-and-conditions/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                showCustomSnackBar(S.current.socialWebError, type: -1);
              }
            },
            icon: const Icon(Icons.description_rounded),
            label: Text(S.current.termsAndConditionsLabel),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              final url = Uri.parse('$baseUrl/cookie-policy/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                showCustomSnackBar(S.current.socialWebError, type: -1);
              }
            },
            icon: const Icon(Icons.cookie_rounded),
            label: Text(S.current.cookiePolicyLabel),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              final url = Uri.parse('$baseUrl/legal-notice/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                showCustomSnackBar(S.current.socialWebError, type: -1);
              }
            },
            icon: const Icon(Icons.gavel_rounded),
            label: Text(S.current.legalNoticeLabel),
          ),
        ],
      ),
    );
  }
}
