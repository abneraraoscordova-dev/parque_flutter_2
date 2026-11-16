import 'package:flutter/material.dart';
import '../services/parque_service.dart';
import 'tecnico_detalle_page.dart';
import 'tecnico_agregar_page.dart';

class TecnicosPage extends StatefulWidget {
  const TecnicosPage({super.key});

  @override
  State<TecnicosPage> createState() => _TecnicosPageState();
}

class _TecnicosPageState extends State<TecnicosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Botón + para ir al formulario y actualizar la lista al volver
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1565C0),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          MaterialPageRoute ruta = MaterialPageRoute(
            builder: (context) => const TecnicoAgregarPage(),
          );
          Navigator.push(context, ruta).then((value) => setState(() {}));
        },
      ),
      body: Align(
        alignment: Alignment.centerRight,
        child: FutureBuilder(
          future: ParqueService().Tecnicos(),
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
                var tecnico = snapshot.data[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF0D47A1),
                    radius: 50,
                    child: Text(
                      '${tecnico['nombre'][0]}${tecnico['apellido'][0]}'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text('${tecnico['nombre']} '),
                      Text(tecnico['apellido'].toString()),
                    ],
                  ),
                  subtitle: Text('Rut: ${tecnico['rut']}'),
                  // 2. Flechita a la derecha
                  trailing: const Icon(Icons.chevron_right),
                  // 3. Al hacer tap, abre la vista de detalle pasando el RUT
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TecnicoDetallePage(
                          tecnicoRut: tecnico['rut'].toString(),
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