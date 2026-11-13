import 'package:flutter/material.dart';

class MenuNagevacion extends StatefulWidget {
  const MenuNagevacion({super.key});

  @override
  State<MenuNagevacion> createState() => _MenuNagevacionState();
}

class _MenuNagevacionState extends State<MenuNagevacion> {
  int indice =0;

  List<String> titulos = [
    'Categorías',
    'Juegos',
    'Técnicos',
    'Mantenimientos'
  ];

  // aqui iran las pantallas centrales que mostraran los datos, de momento soo son texto
  final List <Widget> paginas = [
    const Center(child: Text('Vista Categorias')),
    const Center(child: Text('Vista Juegos')),
    const Center(child: Text('Vista Tecnicos')),
    const Center(child: Text('Vista Mantenimientos')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA ),

      appBar: AppBar(
        title: Text(titulos[indice]),
        backgroundColor: Color(0xFF0D47A1 ),
        foregroundColor: Colors.white,
      ),

      body: paginas[indice],

      bottomNavigationBar: 
        NavigationBar(
        selectedIndex: indice,
        onDestinationSelected: (int index){
          setState(() {
            indice = index;
          });
        },

        //colores de pestaña seleccionada
        backgroundColor: const Color(0xFFE3ECFF ),
        indicatorColor: const Color(0xFFD6E3FF   ),

        // las direcciones del navigatorbar
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.category, color: Color(0xFF44474E),),
            selectedIcon: Icon(Icons.category, color: Color(0xFF0D47A1),),
            label: 'Categorías',

           ),
           NavigationDestination(
            icon: Icon(Icons.attractions, color:  Color(0xFF44474E,)),
            selectedIcon: Icon(Icons.attractions, color: Color(0xFF0D47A1),),
            label: 'Juegos',
           ),
           NavigationDestination(
            icon: Icon(Icons.engineering, color: Color(0xFF44474E),),
            selectedIcon: Icon(Icons.engineering, color: Color(0xFF0D47A1),),
            label: 'Técnicos',
            ),
            NavigationDestination(
              icon: Icon(Icons.build, color: Color(0xFF44474E),),
              selectedIcon: Icon(Icons.build, color: Color(0xFF0D47A1),),
              label: 'Mantenimientos',
              )
           
        ],
        
      ),
    );
  }




  
} 