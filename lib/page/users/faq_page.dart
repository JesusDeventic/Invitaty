import 'package:invitaty/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Página de FAQs (misma estructura que Fitcron FAQPage).
class FAQPage extends StatelessWidget {
  FAQPage({super.key});

  final Map<String, String> faqs = {
    S.current.faq1Question: S.current.faq1Answer,
    S.current.faq2Question: S.current.faq2Answer,
    S.current.faq3Question: S.current.faq3Answer,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.userSectionFAQs,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final key = faqs.keys.elementAt(index);
              final value = faqs[key]!;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ExpansionTile(
                  title: Text(
                    key,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
