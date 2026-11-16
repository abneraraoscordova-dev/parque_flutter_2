import 'dart:convert';
import 'package:http/http.dart' as http;

class ParqueService {

  //aca defino los get para traer la informacion y conectarse con el api

  final String api_URL = 'http://10.0.2.2:8000/api';
  Future<List<dynamic>> Juegos() async {
    var respuesta = await http.get(Uri.parse('${this.api_URL}/juegos'));
    if (respuesta.statusCode == 200){
      return json.decode(respuesta.body);
    }

    return [];
  }

  Future<List<dynamic>> Categorias() async {
    var respuesta = await http.get(Uri.parse('${this.api_URL}/categorias'));
    if (respuesta.statusCode == 200){
      return json.decode(respuesta.body);
    }
    return [];
  }

  Future<List<dynamic>> Mantenimientos() async {
    var respuesta = await http.get(Uri.parse('${this.api_URL}/mantenimientos'));
    if (respuesta.statusCode == 200){
      return json.decode(respuesta.body);
    }
    return [];
  }

  Future<List<dynamic>> Tecnicos() async{

    var respuesta = await http.get(Uri.parse('${this.api_URL}/tecnicos'));
    if (respuesta.statusCode ==200){
      return json.decode(respuesta.body);

    }
    return[];
  }


  // Metodo para buscar 1 juego por su ID 
  Future<dynamic> juego(int id) async{
    var respuesta = await http.get(Uri.parse('${this.api_URL}/juegos/$id'));
      if (respuesta.statusCode ==200){
        return json.decode(respuesta.body);
      }
      return {};

  }

  // Método para buscar 1 tecnico por su RUT
  Future<dynamic> tecnico(String rut) async {
    var respuesta = await http.get(Uri.parse('${this.api_URL}/tecnicos/$rut'));
    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    return {};
  }

  Future<dynamic> mantenimiento(int id) async {
  var respuesta = await http.get(Uri.parse('$api_URL/mantenimientos/$id'));
  if (respuesta.statusCode == 200) {
    return json.decode(respuesta.body);
  }
  return {};
}

// obtener detalle de solo 1 categoria 
Future<dynamic> categoria(int id ) async {
  var respuesta = await http.get(Uri.parse('$api_URL/categorias/$id'));
  if (respuesta.statusCode == 200 ) {
    return json.decode(respuesta.body);
  }
  return {};

}

//agregar 1 categoria (post)
Future <dynamic> agregarCategoria(
  String nombre, 
  int edadMaxima
) 
async {
  var respuesta = await http.post(
    Uri.parse('$api_URL/categorias'),
    headers: {
      'Content-type':'aplication/json',
      'Accept': 'application/json',
    },
    body: json.encode({
      'nombre': nombre,
      'edad_maxima': edadMaxima
    })
  );
  return json.decode(respuesta.body);

}
// 4. Agregar nuevo técnico (HTTP POST - Diapo 6 de Insertar)
  Future<dynamic> agregarTecnico(String rut, String nombre, String apellido) async {
    var respuesta = await http.post(
      Uri.parse('$api_URL/tecnicos'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'rut': rut,
        'nombre': nombre,
        'apellido': apellido,
      }),
    );
    return json.decode(respuesta.body);
  }
}