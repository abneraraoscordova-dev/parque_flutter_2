import 'dart:convert';
import 'package:http/http.dart' as http;

class ParqueService {

  //aca defino los get para traer la informacion y conectarse con el api

  final String api_URL = 'http://127.0.0.1:8000/api';
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
}
