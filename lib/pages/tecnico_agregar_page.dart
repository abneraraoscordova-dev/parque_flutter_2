import 'package:flutter/material.dart';
import '../services/parque_service.dart';

class TecnicoAgregarPage extends StatefulWidget {
  const TecnicoAgregarPage({super.key});

  @override
  State<TecnicoAgregarPage> createState() => _TecnicoAgregarPageState();
}

class _TecnicoAgregarPageState extends State<TecnicoAgregarPage> {
  final formAgregar = GlobalKey<FormState>();
  final rutCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  bool guardando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Text('Nuevo técnico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formAgregar,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // RUT
              TextFormField(
                controller: rutCtrl,
                decoration: const InputDecoration(
                  labelText: 'RUT',
                  hintText: 'Ej: 12345678-9',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              // Nombre
              TextFormField(
                controller: nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ej: Juan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              // Apellido
              TextFormField(
                controller: apellidoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  hintText: 'Ej: Pérez',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Botón Guardar
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
                      var respuesta = await ParqueService().agregarTecnico(
                        rutCtrl.text.trim(),
                        nombreCtrl.text.trim(),
                        apellidoCtrl.text.trim(),
                      );
                      if (!mounted) return;
                      if (respuesta.containsKey('errors')) return;
                      Navigator.pop(context);
                    } finally {
                      guardando = false;
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Botón Volver
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Volver'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}