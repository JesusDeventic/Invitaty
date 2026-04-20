import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invitaty/generated/l10n.dart';

import 'package:invitaty/providers/invitation_provider.dart';

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
  late TextEditingController titleController;
  late TextEditingController messageController;
  late TextEditingController ibanController;
  late TextEditingController bizumController;
  late TextEditingController linkController;

  List<TextEditingController> itemControllers = [];

  @override
  void initState() {
    super.initState();

    final data = widget.section["data"] ?? {};

    titleController = TextEditingController(
      text: data["title"] ?? S.of(context).moduleNameGifts,
    );
    messageController = TextEditingController(text: data["message"] ?? "");
    ibanController = TextEditingController(text: data["iban"] ?? "");
    bizumController = TextEditingController(text: data["bizum"] ?? "");
    linkController = TextEditingController(text: data["link"] ?? "");

    final items = List<String>.from(data["items"] ?? []);
    itemControllers = items.map((e) => TextEditingController(text: e)).toList();
  }

  @override
  void dispose() {
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

  // ➕ ITEM
  void _addItem() {
    setState(() {
      itemControllers.add(TextEditingController(text: ""));
    });
  }

  // ❌ ITEM
  void _removeItem(int index) {
    setState(() {
      itemControllers[index].dispose();
      itemControllers.removeAt(index);
    });
  }

  // 💾 GUARDAR
  void _save() {
    final provider = context.read<InvitationProvider>();

    final items = itemControllers
        .map((c) => c.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();

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

  // ❌ DELETE MODULO
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

  Widget _buildItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.card_giftcard),
            const SizedBox(width: 8),

            Expanded(
              child: TextField(
                controller: itemControllers[index],
                decoration: InputDecoration(labelText: S.of(context).nameGift),
              ),
            ),

            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editGifts),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _deleteModule,
          ),
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: S.of(context).editTitle),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: messageController,
            decoration: InputDecoration(
              labelText: S.of(context).messagesTypeHint,
            ),
          ),

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

          TextField(
            controller: linkController,
            decoration: InputDecoration(labelText: S.of(context).labelLink),
          ),

          _sectionTitle(S.of(context).editGiftIdeas),

          ...List.generate(itemControllers.length, _buildItem),

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
