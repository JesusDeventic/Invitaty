import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';

class RsvpModule extends StatefulWidget {
  final Map<String, dynamic> data;

  const RsvpModule({super.key, required this.data});

  @override
  State<RsvpModule> createState() => _RsvpModuleState();
}

class _RsvpModuleState extends State<RsvpModule> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> controllers = {};
  final Map<String, dynamic> formValues = {};

  @override
  void initState() {
    super.initState();

    final fields = List<Map<String, dynamic>>.from(widget.data["fields"] ?? []);

    for (final field in fields) {
      final key = field["key"];

      if (field["type"] == "switch") {
        formValues[key] = field["default"] ?? false;
      } else {
        controllers[key] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildField(Map<String, dynamic> field) {
    final type = field["type"] ?? "text";
    final key = field["key"] ?? "";
    final label = field["label"] ?? "";
    final required = field["required"] ?? false;

    switch (type) {
      case "text":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label),
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return S.of(context).fieldMandatory;
            }
            return null;
          },
        );

      case "email":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return S.of(context).fieldMandatory;
            }

            if (value != null && value.isNotEmpty && !value.contains("@")) {
              return S.of(context).invalidEmail;
            }

            return null;
          },
        );

      case "number":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return S.of(context).fieldMandatory;
            }
            return null;
          },
        );

      case "textarea":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label),
          maxLines: 3,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return S.of(context).fieldMandatory;
            }
            return null;
          },
        );

      case "switch":
        return SwitchListTile(
          title: Text(label),
          value: formValues[key] ?? false,
          onChanged: (value) {
            setState(() {
              formValues[key] = value;
            });
          },
        );

      case "select":
        final options = List<String>.from(field["options"] ?? []);

        // valor inicial
        formValues[key] ??= options.isNotEmpty ? options.first : null;

        return DropdownButtonFormField<String>(
          value: formValues[key],
          decoration: InputDecoration(labelText: label),
          items: options
              .map(
                (option) =>
                    DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              formValues[key] = value;
            });
          },
          validator: (value) {
            if (required && (value == null || value.isEmpty)) {
              return S.of(context).fieldMandatory;
            }
            return null;
          },
        );

      case "radio":
        final options = List<String>.from(field["options"] ?? []);

        // valor inicial
        formValues[key] ??= options.isNotEmpty ? options.first : null;

        return RadioGroup<String>(
          groupValue: formValues[key] as String?,
          onChanged: (value) {
            setState(() {
              formValues[key] = value;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ), // 🔤 traducir label

              ...options.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                );
              }),

              if (required &&
                  (formValues[key] == null || formValues[key].isEmpty))
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    S.of(context).fieldMandatory,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final result = <String, dynamic>{};

    for (final entry in controllers.entries) {
      result[entry.key] = entry.value.text;
    }

    result.addAll(formValues);

    print("RSVP enviado:"); // 🔤 traducir (opcional, debug)
    print(result);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(S.of(context).sentConfirmation)));
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.data["title"] ?? S.of(context).attendanceConfirmation;

    final description = widget.data["description"] ?? "";

    final fields = List<Map<String, dynamic>>.from(widget.data["fields"] ?? []);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            if (description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(description, textAlign: TextAlign.center),
            ],

            const SizedBox(height: 20),

            ...fields.map((field) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildField(field),
              );
            }),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text(S.of(context).agreeAttendance),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
