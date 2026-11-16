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
  var respuesta = await http.get(Uri.parse('${this.api_URL}/mantenimientos/$id'));
  if (respuesta.statusCode == 200) {
    return json.decode(respuesta.body);
  }
  return {};
}

}