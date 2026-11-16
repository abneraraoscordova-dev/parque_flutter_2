import 'package:flutter/material.dart';
import '../services/parque_service.dart';
import 'categoria_detalle_page.dart';
import 'categoria_agregar_page.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Botón + igual a la diapo 7 de Insertar del profesor
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1565C0),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          MaterialPageRoute ruta = MaterialPageRoute(
            builder: (context) => const CategoriaAgregarPage(),
          );
          Navigator.push(context, ruta).then((value) => setState(() {}));
        },
      ),
      body: Align(
        alignment: Alignment.centerRight,
        child: FutureBuilder(
          future: ParqueService().Categorias(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                var categorias = snapshot.data[index];
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE3ECFF),
                    child: Icon(
                      Icons.category,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  title: Text(categorias['nombre'].toString()),
                  // 2. Corregido a 'edad_maxima' según la BD del Ejercicio 03
                  subtitle: Text('Edad minima: ${categorias['edad_minima']} años'),
                  // 3. Flechita a la derecha que pide la tabla de íconos
                  trailing: const Icon(Icons.chevron_right),
                  // 4. Al hacer tap, abre la vista de detalle (Diapo 4 Vista de Detalle)
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriaDetallePage(
                          categoriaId: categorias['id'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}