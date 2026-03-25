import 'package:flutter/material.dart';

class RsvpModule extends StatefulWidget {
  final Map<String, dynamic> data;

  const RsvpModule({super.key, required this.data});

  @override
  State<RsvpModule> createState() => _RsvpModuleState();
}

class _RsvpModuleState extends State<RsvpModule> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final guestsController = TextEditingController();
  final notesController = TextEditingController();

  bool attending = true;

  @override
  Widget build(BuildContext context) {
    final fields = List<String>.from(widget.data["fields"] ?? []);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            if (fields.contains("name"))
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),

            if (fields.contains("email"))
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),

            if (fields.contains("attending"))
              SwitchListTile(
                title: const Text("¿Asistirás?"),
                value: attending,
                onChanged: (value) {
                  setState(() {
                    attending = value;
                  });
                },
              ),

            if (fields.contains("guests"))
              TextFormField(
                controller: guestsController,
                decoration: const InputDecoration(labelText: "Invitados"),
                keyboardType: TextInputType.number,
              ),

            if (fields.contains("notes"))
              TextFormField(
                controller: notesController,
                decoration: const InputDecoration(labelText: "Notas"),
              ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                print("Nombre: ${nameController.text}");
                print("Email: ${emailController.text}");
                print("Asiste: $attending");
                print("Invitados: ${guestsController.text}");
                print("Notas: ${notesController.text}");

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("RSVP enviado (simulado)")),
                );
              },
              child: const Text("Confirmar asistencia"),
            ),
          ],
        ),
      ),
    );
  }
}
