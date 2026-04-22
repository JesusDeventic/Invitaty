import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/generated/l10n.dart';

import 'package:invitaty/providers/invitation_provider.dart';

/// 🎁 EDITOR DEL MÓDULO DE REGALOS
/// Permite modificar toda la información del bloque GiftsModule:
/// - Título del módulo
/// - Mensaje descriptivo
/// - IBAN / Bizum / Link
/// - Lista de ideas de regalo (dinámica)
class EditGiftsModuleScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> section;

  const EditGiftsModuleScreen({
    super.key,
    required this.index,
    required this.section,
  });

  @override
  State<EditGiftsModuleScreen> createState() => _EditGiftsModuleScreenState();
}

class _EditGiftsModuleScreenState extends State<EditGiftsModuleScreen> {
  /// 🧠 CONTROLADORES PRINCIPALES
  /// Se usan para editar los campos básicos del módulo
  late TextEditingController titleController;
  late TextEditingController messageController;
  late TextEditingController ibanController;
  late TextEditingController bizumController;
  late TextEditingController linkController;

  /// 📋 LISTA DINÁMICA DE IDEAS DE REGALO
  /// Cada item es un TextEditingController independiente
  /// (permite edición directa en UI)
  List<TextEditingController> itemControllers = [];

  @override
  void initState() {
    super.initState();

    /// 📦 DATOS INICIALES DEL MÓDULO
    /// Se reciben desde el provider (estado global)
    final data = widget.section["data"] ?? {};

    /// 🏷️ CAMPOS PRINCIPALES DEL MÓDULO
    /// IMPORTANTE: aquí aún NO hay backend, todo es local state
    titleController = TextEditingController(
      text: data["title"] ?? S.of(context).moduleNameGifts,
    );

    messageController = TextEditingController(text: data["message"] ?? "");
    ibanController = TextEditingController(text: data["iban"] ?? "");
    bizumController = TextEditingController(text: data["bizum"] ?? "");
    linkController = TextEditingController(text: data["link"] ?? "");

    /// 🎁 LISTA DE ITEMS (IDEAS DE REGALO)
    /// Convertimos JSON → controllers editables
    final items = List<String>.from(data["items"] ?? []);
    itemControllers = items.map((e) => TextEditingController(text: e)).toList();
  }

  @override
  void dispose() {
    /// 🧹 LIBERACIÓN DE MEMORIA
    /// IMPORTANTE: evitar leaks de TextEditingController

    titleController.dispose();
    messageController.dispose();
    ibanController.dispose();
    bizumController.dispose();
    linkController.dispose();

    for (final c in itemControllers) {
      c.dispose();
    }

    super.dispose();
  }

  // ➕ ADD ITEM
  /// Añade un nuevo campo vacío de idea de regalo
  void _addItem() {
    setState(() {
      itemControllers.add(TextEditingController(text: ""));
    });
  }

  // ❌ REMOVE ITEM
  /// Elimina un item y libera su controller
  void _removeItem(int index) {
    setState(() {
      itemControllers[index].dispose();
      itemControllers.removeAt(index);
    });
  }

  // 💾 SAVE MODULE
  /// Construye el objeto final y lo guarda en el provider
  /// ⚠️ IMPORTANTE: todavía sin backend real
  void _save() {
    final provider = context.read<InvitationProvider>();

    /// 🧾 NORMALIZACIÓN DE ITEMS
    /// Se eliminan vacíos antes de guardar
    final items = itemControllers
        .map((c) => c.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    /// 📦 OBJETO FINAL DEL MÓDULO
    final updatedSection = {
      ...widget.section,
      "data": {
        "title": titleController.text,
        "message": messageController.text,
        "iban": ibanController.text,
        "bizum": bizumController.text,
        "link": linkController.text,
        "items": items,
      },
    };

    provider.updateSection(widget.index, updatedSection);
    Navigator.pop(context);
  }

  // 🗑 DELETE MODULE
  /// Elimina completamente el módulo del provider
  /// (acción destructiva con confirmación)
  Future<void> _deleteModule() async {
    final provider = context.read<InvitationProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).deleteGifts),
          content: Text(S.of(context).deleteModuleConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(S.of(context).buttonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(S.of(context).messagesDelete),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      provider.removeSection(widget.index);
      Navigator.pop(context);
    }
  }

  // 🧩 WIDGET ITEM EDITOR
  /// Representa cada idea de regalo como un campo editable
  Widget _buildItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          children: [
            /// 🎁 ICONO VISUAL DEL ITEM
            const Icon(Icons.card_giftcard),
            const SizedBox(width: 8),

            /// ✏️ CAMPO EDITABLE
            Expanded(
              child: TextField(
                controller: itemControllers[index],
                decoration: InputDecoration(labelText: S.of(context).nameGift),
              ),
            ),

            /// 🗑 BORRAR ITEM
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeItem(index),
            ),
          ],
        ),
      ),
    );
  }

  // 🏷️ SECTION HEADER
  /// Simple helper para separar visualmente bloques del editor
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 📱 UI PRINCIPAL DEL EDITOR
    return Scaffold(
      appBar: AppBar(
        /// 🏷️ TÍTULO DEL EDITOR
        title: Text(S.of(context).editGifts),

        actions: [
          /// 🗑 DELETE MODULE BUTTON
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _deleteModule,
          ),

          /// 💾 SAVE MODULE BUTTON
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// 🏷️ TITULO
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: S.of(context).editTitle),
          ),

          const SizedBox(height: 12),

          /// 💬 MENSAJE
          TextField(
            controller: messageController,
            decoration: InputDecoration(
              labelText: S.of(context).messagesTypeHint,
            ),
          ),

          /// 💰 BLOQUE DE OPCIONES ECONÓMICAS
          _sectionTitle(S.of(context).labelOptions),

          TextField(
            controller: ibanController,
            decoration: InputDecoration(labelText: S.of(context).labelIban),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: bizumController,
            decoration: InputDecoration(labelText: S.of(context).labelBizum),
          ),

          const SizedBox(height: 12),

          /// 🔗 LINK EXTERNO
          TextField(
            controller: linkController,
            decoration: InputDecoration(labelText: S.of(context).labelLink),
          ),

          /// 🎁 LISTA DE IDEAS DE REGALO
          _sectionTitle(S.of(context).editGiftIdeas),

          ...List.generate(itemControllers.length, _buildItem),

          /// ➕ ADD ITEM BUTTON
          ElevatedButton.icon(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
            label: Text(S.of(context).editAddGift),
          ),
        ],
      ),
    );
  }
}
