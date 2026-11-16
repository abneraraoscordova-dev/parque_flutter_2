import 'package:flutter/material.dart';
import '../services/parque_service.dart';

class TecnicosPage extends StatelessWidget {
  const TecnicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.centerRight,
        child: FutureBuilder(
          future: ParqueService().Tecnicos(),
          builder: (context,AsyncSnapshot snapshot){
            if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                var tecnico = snapshot.data[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF0D47A1),
                    radius: 50,
                    child: Text('${tecnico['nombre'][0]} ${tecnico['apellido'][0]}'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(tecnico['nombre'].toString(),),
                      Text(tecnico['apellido'].toString(),)
                    ],
                  ),
                  subtitle: Text('Rut: ${tecnico['rut']}',)

                );

              },
            );
          }

        ),
        
      ),

    );
  }
}