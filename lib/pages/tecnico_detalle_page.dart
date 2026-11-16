import 'package:flutter/material.dart';
import '../services/parque_service.dart';

class TecnicoDetallePage extends StatelessWidget {
  const TecnicoDetallePage({
    super.key,
    required this.tecnicoRut,
  });

  final String tecnicoRut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Text('Detalle de técnico'),
      ),
      body: FutureBuilder(
        future: ParqueService().tecnico(tecnicoRut),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var tecnico = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar grande con iniciales y nombre al centro
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF0D47A1),
                        radius: 30,
                        child: Text(
                          '${tecnico['nombre'][0]}${tecnico['apellido'][0]}'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${tecnico['nombre']} ${tecnico['apellido']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('RUT'),
                    Text(
                      tecnico['rut'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre'),
                    Text(
                      tecnico['nombre'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Apellido'),
                    Text(
                      tecnico['apellido'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),
                const Text(
                  'MANTENIMIENTOS REALIZADOS',
                  style: TextStyle(
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Lista de mantenimientos del técnico (Diapo 8 Vista de Detalle)
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: tecnico['mantenimientos'].length,
                    itemBuilder: (context, index) {
                      var mantenimiento = tecnico['mantenimientos'][index];
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFE3ECFF),
                          child: Icon(Icons.build, color: Color(0xFF0D47A1)),
                        ),
                        // Buscamos el nombre del juego usando juego_id como en mantenimientos_pages
                        title: FutureBuilder(
                          future: ParqueService().juego(mantenimiento['juego_id']),
                          builder: (context, AsyncSnapshot snapJuego) {
                            if (!snapJuego.hasData) {
                              return const Text('Cargando...');
                            }
                            var juego = snapJuego.data;
                            return Text(juego['nombre'].toString());
                          },
                        ),
                        subtitle: Text(mantenimiento['fecha'].toString()),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}