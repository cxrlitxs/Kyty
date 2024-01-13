import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin{

  HttpAdmin();

  Future<double> askTemperaturesIn(double lat, double lon) async{
    var url = Uri.https('api.open-meteo.com', '/v1/forecast',
        {'latitude': lat.toString(),
          'longitude': lon.toString(),
          'hourly': 'temperature_2m',
        });
    //Pintar la url para ver cual es y si es correcta
    //print("URL RESULTANTE: "+url.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      //print("MAPA ENTERO: "+jsonResponse.toString());
      var horas = jsonResponse['hourly_units'];
      //print ("UNIDAD HORARIA : "+horas.toString());
      //print ("HORAS : "+jsonResponse['hourly'].toString());
      DateTime now = DateTime.now();
      int hour = now.hour;

      var jsonHourly = jsonResponse['hourly'];
      var jsonTimes=jsonHourly['time'];
      var jsonTime0=jsonTimes[hour];
      var jsonTemperatures=jsonHourly['temperature_2m'];
      var jsonTemperature0=jsonTemperatures[hour];

      //Posibles usos
      //print("TEMPERATURAS: "+jsonTemperatures.toString());
      //print("LA TEMPERATURA EN A LAS "+jsonTime0.toString()+" FUE "+jsonTemperature0.toString());
      //print ("TIEMPO : "+jsonHourly['time'].toString());
      //print ("TIEMPO EN LA POSICION 0 : "+jsonResponse['hourly']['time'][0].toString());
      //var itemCount = jsonResponse['totalItems'];
      //print('Number of books about http: $itemCount.');

      return jsonTemperature0;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return 0;
    }
  }

  Future<List<String>> obtenerTiposDePokemons() async{
    var url = Uri.https('pokeapi.co', '/api/v2/pokemon/');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      var results = jsonResponse['results'] as List<dynamic>;

      List<String> nombres = results.map<String>((result) => result['name'] as String).toList();
      nombres.add('Ninguno');
      return nombres;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

}