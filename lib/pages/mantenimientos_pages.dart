import 'package:flutter/material.dart';
import '../services/parque_service.dart';
class MantenimientosPages extends StatelessWidget {
  const MantenimientosPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.centerRight,
        child: FutureBuilder(
          future: ParqueService().Mantenimientos(),
          builder: (context,AsyncSnapshot snapshot) {
            if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            };
            return ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {

                var mantenimiento = snapshot.data[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFE3ECFF),
                    child: Icon(Icons.build, color: Color(0xFF0D47A1),),
                  ),
                  

                  title: FutureBuilder(
                    future: ParqueService().juego(mantenimiento['juego_id']),
                    builder:(context, AsyncSnapshot snapJuego) {
                      if(!snapJuego.hasData){
                        return Text('Cargando...');
                      }
                      var juego = snapJuego.data;
                      return Text(
                        juego['nombre'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    }
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.event),
                          Text(mantenimiento['fecha'].toString()),
                        ],
                      ),
                      

                      FutureBuilder(
                        future: ParqueService().tecnico(mantenimiento['tecnico_rut']),
                        builder: (context, AsyncSnapshot snapTecnico){
                          if (!snapTecnico.hasData){
                            return Text('Cargando..');
                          }
                          var tecnico = snapTecnico.data;
                          return Row(
                            spacing: 3,
                            children: [

                              Icon(Icons.person),
                              Text(tecnico['nombre']),
                              Text(tecnico['apellido']),
                            ],
                          );
                        }

                      ),

                      FutureBuilder(
                         future: ParqueService().mantenimiento(mantenimiento['id']),
                         builder: (context, AsyncSnapshot snapMant) {
                            if (!snapMant.hasData) {
                              return Text('Cargando..');
                               }
                             var detalle = snapMant.data;
                                  return Text(detalle['observaciones'].toString());
                                        },
                            ),
                     
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}