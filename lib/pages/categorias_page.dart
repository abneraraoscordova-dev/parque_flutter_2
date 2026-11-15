import 'package:flutter/material.dart';
import '../services/parque_service.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Align(
        alignment: Alignment.centerRight,
        child: FutureBuilder(

          future: ParqueService().Categorias(),
          builder: (context,AsyncSnapshot snapshot){
            if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){

               return Center(
               child: CircularProgressIndicator(),

            );
            }
           return ListView.separated(
            itemCount: snapshot.data.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              var categorias = snapshot.data[index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFE3ECFF),
                  child: Icon(Icons.category_outlined, color: Color(0xFF0D47A1 ),),),
                  title: Text(categorias['nombre'].toString(),),
                  subtitle: Text('Edad minima: ${categorias['edad_minima']}',),
              );

            },
           );
          }
        ),
      ),
    );

}
}