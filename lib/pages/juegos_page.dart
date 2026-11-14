import 'package:flutter/material.dart';
import '../services/parque_service.dart';

class JuegosPage extends StatelessWidget {
  const JuegosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(5),
        child: FutureBuilder
        (
        future: ParqueService().Juegos(),
        builder: (context,AsyncSnapshot snapshot){
          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: CircularProgressIndicator(), //indicador de carga

            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              var juego = snapshot.data[index];
              return ListTile(
                leading: Icon(Icons.attractions),
                title: Text(juego['nombre'].toString()),
                subtitle: Text('Valor Entrada: \$${juego['valor_entrada']}'),
              );
            }
          );
        }
        

        ),
      ),

    );
  }
}