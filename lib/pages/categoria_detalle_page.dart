import 'package:flutter/material.dart';
import '../services/parque_service.dart';

class CategoriaDetallePage extends StatelessWidget {
  final int categoriaId;

  const CategoriaDetallePage({
    super.key,
    required this.categoriaId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        title: const Text('Detalle de categoría'),
      ),
      body: FutureBuilder(
        future: ParqueService().categoria(categoriaId),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Si tu API envuelve en ['data'], cámbialo a snapshot.data['data']
          var categoria = snapshot.data;
          List juegos = categoria['juegos'] ?? [];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tarjeta superior con el avatar grande y nombre centrado
                Card(
                  color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFFE3ECFF),
                          child: Icon(Icons.category, size: 30, color: Color(0xFF0D47A1)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          categoria['nombre'].toString(),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Tarjeta con los datos ID, Nombre y Edad máxima
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('ID', style: TextStyle(color: Color(0xFF5A5F69))),
                            Text('${categoria['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(color: Color(0xFFE0E3EA)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Nombre', style: TextStyle(color: Color(0xFF5A5F69))),
                            Text('${categoria['nombre']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(color: Color(0xFFE0E3EA)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Edad Minima', style: TextStyle(color: Color(0xFF5A5F69))),
                            Text('${categoria['edad_minima']} años', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Título de la sección inferior
                const Text(
                  'JUEGOS DE ESTA CATEGORÍA',
                  style: TextStyle(
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Lista de juegos de la categoría (Diapo 8 Vista de Detalle)
                Expanded(
                  child: Card(
                    color: Colors.white,
                    child: ListView.separated(
                      itemCount: juegos.length,
                      separatorBuilder: (context, index) => const Divider(color: Color(0xFFE0E3EA)),
                      itemBuilder: (context, index) {
                        var juego = juegos[index];
                        return ListTile(
                          leading: const CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFFE3ECFF),
                            child: Icon(Icons.attractions, size: 18, color: Color(0xFF0D47A1)),
                          ),
                          title: Text(juego['nombre'].toString()),
                          trailing: Text(
                            '\$${juego['valor_entrada']}',
                            style: const TextStyle(
                              color: Color(0xFF1565C0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
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