import 'package:flutter/material.dart';
import '../services/parque_service.dart';

class JuegosPage extends StatelessWidget {
  const JuegosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.centerRight,
        child: FutureBuilder
        (
        future: ParqueService().Juegos(),
        builder: (context,AsyncSnapshot snapshot){
          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
            return Center(
                child: CircularProgressIndicator(), //indicador de carga

            );
          }
          return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index){
              var juego = snapshot.data[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFE3ECFF),
                  child: Icon(Icons.attractions, color: Color(0xFF0D47A1),),
                ),
               
                title: Text(juego['nombre'].toString(),),
                
                subtitle: Text('Valor Entrada: \$${juego['valor_entrada']}',),
                
              );
              
            }
          );
        }
        

        ),
      ),

    );
  }
}