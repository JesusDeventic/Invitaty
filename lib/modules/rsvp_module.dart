import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

/// 🧾 RSVP MODULE (FORMULARIO DINÁMICO)
/// Renderiza un formulario basado en configuración JSON.
/// Cada campo se construye dinámicamente según su tipo.
class RsvpModule extends StatefulWidget {
  final Map<String, dynamic> data;

  const RsvpModule({
    super.key,
    required this.data,
    required InvitationTheme theme,
  });

  @override
  State<RsvpModule> createState() => _RsvpModuleState();
}

class _RsvpModuleState extends State<RsvpModule> {
  /// 🧠 KEY GLOBAL DEL FORMULARIO
  /// Permite validar todo el formulario de una sola vez
  final _formKey = GlobalKey<FormState>();

  /// ✏️ CONTROLADORES DE CAMPOS DE TEXTO
  /// Solo se usan para inputs tipo text/email/number/textarea
  final Map<String, TextEditingController> controllers = {};

  /// 📦 VALORES NO-TEXTO
  /// Switches, selects, radios, etc.
  final Map<String, dynamic> formValues = {};

  @override
  void initState() {
    super.initState();

    /// 📥 CAMPOS DEFINIDOS EN EL JSON DEL MÓDULO
    final fields = List<Map<String, dynamic>>.from(widget.data["fields"] ?? []);

    /// 🔁 INICIALIZACIÓN DE ESTADO DEL FORMULARIO
    /// - TextFields → controllers
    /// - Switch → valores booleanos
    for (final field in fields) {
      final key = field["key"];

      if (field["type"] == "switch") {
        /// 🔘 SWITCH FIELD
        /// valor por defecto si existe, si no false
        formValues[key] = field["default"] ?? false;
      } else {
        /// ✏️ TEXT FIELD
        controllers[key] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    /// 🧹 CLEANUP DE CONTROLADORES
    /// Evita memory leaks
    for (final controller in controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  /// 🧩 BUILDER DE CAMPOS DINÁMICOS
  /// Genera UI según tipo de campo definido en JSON
  Widget _buildField(Map<String, dynamic> field) {
    final type = field["type"] ?? "text";
    final key = field["key"] ?? "";
    final label = field["label"] ?? "";
    final placeholder = field["placeholder"] ?? "";
    final required = field["required"] ?? false;

    switch (type) {
      /// ✏️ INPUT DE TEXTO NORMAL
      case "text":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label, hintText: placeholder),
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return S.of(context).fieldMandatory;
            }
            return null;
          },
        );

      /// 📧 EMAIL FIELD
      case "email":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label, hintText: placeholder),
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

      /// 🔢 NUMBER FIELD
      case "number":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label, hintText: placeholder),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return S.of(context).fieldMandatory;
            }
            return null;
          },
        );

      /// 📝 TEXTAREA MULTILÍNEA
      case "textarea":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label, hintText: placeholder),
          maxLines: 3,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return S.of(context).fieldMandatory;
            }
            return null;
          },
        );

      /// 🔘 SWITCH (BOOLEANO)
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

      /// 📋 SELECT (DROPDOWN)
      case "select":
        final options = List<String>.from(field["options"] ?? []);

        /// 🔁 valor inicial si no existe
        formValues[key] ??= options.isNotEmpty ? options.first : null;

        return DropdownButtonFormField<String>(
          value: formValues[key],
          decoration: InputDecoration(labelText: label, hintText: placeholder),
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

      /// 🔘 RADIO GROUP
      case "radio":
        final options = List<String>.from(field["options"] ?? []);

        /// 🔁 valor inicial
        formValues[key] ??= options.isNotEmpty ? options.first : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🏷️ LABEL DEL GRUPO
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),

            /// 🔘 OPCIONES RADIO
            ...options.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: formValues[key],
                onChanged: (value) {
                  setState(() {
                    formValues[key] = value;
                  });
                },
              );
            }),

            /// ⚠️ VALIDACIÓN VISUAL EXTRA (NO FORM VALIDATOR)
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
        );

      default:
        return const SizedBox.shrink();
    }
  }

  /// 📤 SUBMIT DEL FORMULARIO
  /// Junta todos los valores (controllers + formValues)
  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final result = <String, dynamic>{};

    /// 🧾 TEXT INPUTS
    for (final entry in controllers.entries) {
      result[entry.key] = entry.value.text;
    }

    /// 📦 NON-TEXT INPUTS
    result.addAll(formValues);

    /// 🧪 DEBUG (SIN BACKEND AÚN)
    print("RSVP enviado:");
    print(result);

    /// 📣 FEEDBACK UI
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(S.of(context).sentConfirmation)));
  }

  @override
  Widget build(BuildContext context) {
    /// 🧾 DATOS DEL MÓDULO
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
            /// 🏷️ TÍTULO DEL FORMULARIO
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            /// 💬 DESCRIPCIÓN OPCIONAL
            if (description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(description, textAlign: TextAlign.center),
            ],

            const SizedBox(height: 20),

            /// 🧩 CAMPOS DINÁMICOS
            ...fields.map((field) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildField(field),
              );
            }),

            const SizedBox(height: 8),

            /// 📤 BOTÓN DE ENVÍO
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
