import 'package:flutter/material.dart';
import '../services/parque_service.dart';

class CategoriaAgregarPage extends StatefulWidget {
  const CategoriaAgregarPage({super.key});

  @override
  State<CategoriaAgregarPage> createState() => _CategoriaAgregarPageState();
}

class _CategoriaAgregarPageState extends State<CategoriaAgregarPage> {
  final formKey = GlobalKey<FormState>();
  final nombreCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  bool guardando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Text('Nueva categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: nombreCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Ej: Infantiles',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Edad minima', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: edadCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Ej: 12',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botón Guardar (Diapo 4 y 5 Insertar)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                      ),
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                      onPressed: () async {
                        if (guardando) return;
                        guardando = true;
                        try {
                          await ParqueService().agregarCategoria(
                            nombreCtrl.text.trim(),
                            int.tryParse(edadCtrl.text.trim()) ?? 0,
                          );
                          if (!mounted) return;
                          Navigator.pop(context);
                        } finally {
                          guardando = false;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Botón Volver
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
                      label: const Text('Volver', style: TextStyle(color: Color(0xFF0D47A1))),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}