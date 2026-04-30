import 'package:flutter/material.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/themes/invitation_theme.dart';

/// 🧾 RSVP MODULE (FORMULARIO DINÁMICO)
/// Renderiza un formulario basado en configuración JSON.
/// Cada campo se construye dinámicamente según su tipo.
class RsvpModule extends StatefulWidget {
  final Map<String, dynamic> data;

  /// 🎨 THEME GLOBAL DE LA INVITACIÓN
  final InvitationTheme theme;

  const RsvpModule({super.key, required this.data, required this.theme});

  @override
  State<RsvpModule> createState() => _RsvpModuleState();
}

class _RsvpModuleState extends State<RsvpModule> {
  /// 🧠 KEY GLOBAL DEL FORMULARIO
  final _formKey = GlobalKey<FormState>();

  /// ✏️ CONTROLADORES DE CAMPOS DE TEXTO
  /// Solo se usan para inputs tipo text/email/number/textarea
  final Map<String, TextEditingController> controllers = {};

  /// 📦 VALORES NO-TEXTO
  final Map<String, dynamic> formValues = {};

  @override
  void initState() {
    super.initState();

    /// 📥 CAMPOS DEFINIDOS EN EL JSON DEL MÓDULO
    final fields = List<Map<String, dynamic>>.from(widget.data["fields"] ?? []);

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
    for (final c in controllers.values) {
      c.dispose();
    }

    super.dispose();
  }

  // 🎨 HEX → COLOR
  Color? _hexToColor(dynamic value) {
    if (value == null) return null;

    try {
      String hex = value.toString().trim();

      if (hex.startsWith("#")) hex = hex.substring(1);
      if (hex.startsWith("0x")) hex = hex.substring(2);
      if (hex.length == 6) hex = "FF$hex";

      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return null;
    }
  }

  /// 🧩 BUILDER DE CAMPOS DINÁMICOS (SIN CAMBIOS DE LÓGICA)
  Widget _buildField(Map<String, dynamic> field) {
    final type = field["type"] ?? "text";
    final key = field["key"] ?? "";
    final label = field["label"] ?? "";
    final placeholder = field["placeholder"] ?? "";
    final required = field["required"] ?? false;

    /// 🔤 FONT FIJA (RSVP NO USA THEME FONT)
    final font = "Poppins";

    /// 🎨 COLOR FIJO (RSVP LIMPIO Y LEGIBLE)
    final textColor = Colors.black;

    final primaryColor =
        _hexToColor(field["primaryColor"]) ?? widget.theme.primaryColor;

    /// 📏 SIZE BASE
    final fontSize =
        (field["fontSize"] as num?)?.toDouble() ?? widget.theme.bodyFontSize;

    TextStyle baseStyle() =>
        TextStyle(fontFamily: font, fontSize: fontSize, color: textColor);

    switch (type) {
      /// ✏️ INPUT DE TEXTO NORMAL
      case "text":
        return TextFormField(
          controller: controllers[key],
          decoration: InputDecoration(labelText: label, hintText: placeholder),
          style: baseStyle(),
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
          style: baseStyle(),
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
          style: baseStyle(),
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
          style: baseStyle(),
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
          title: Text(label, style: baseStyle()),
          value: formValues[key] ?? false,
          activeColor: primaryColor,
          onChanged: (value) {
            setState(() => formValues[key] = value);
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
          style: baseStyle(),
          items: options
              .map(
                (option) =>
                    DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
          onChanged: (value) {
            setState(() => formValues[key] = value);
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
            Text(
              label,
              style: baseStyle().copyWith(fontWeight: FontWeight.bold),
            ),

            ...options.map((o) {
              return RadioListTile<String>(
                value: o,
                groupValue: formValues[key],
                onChanged: (v) => setState(() => formValues[key] = v),
                activeColor: primaryColor,
                title: Text(o, style: baseStyle()),
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

  /// 📤 SUBMIT (SIN CAMBIOS)
  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final result = <String, dynamic>{};

    for (final e in controllers.entries) {
      result[e.key] = e.value.text;
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
    final theme = widget.theme;

    final title = widget.data["title"] ?? S.of(context).attendanceConfirmation;

    final description = widget.data["description"] ?? "";

    final fields = List<Map<String, dynamic>>.from(widget.data["fields"] ?? []);

    /// 🔤 RSVP FIX FONT (global form)
    final font = "Poppins";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),

      /// 🎨 SOLO CONTENEDOR USA THEME
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.15)),
      ),

      child: Form(
        key: _formKey,

        child: Column(
          children: [
            /// 🏷️ TÍTULO (CON THEME)
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: theme.titleFontSize,
                fontWeight: FontWeight.bold,
                fontFamily: font,
                color: Colors.black,
              ),
            ),

            /// 💬 SUBTÍTULO (CON THEME)
            if (description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
              ),
            ],

            const SizedBox(height: 20),

            /// 🧩 CAMPOS (SIN CAMBIOS DE ESTILO)
            ...fields.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildField(f),
              ),
            ),

            const SizedBox(height: 8),

            /// 📤 BOTÓN (CON THEME)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,

                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.accentColor,
                ),

                child: Text(
                  S.of(context).agreeAttendance,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
