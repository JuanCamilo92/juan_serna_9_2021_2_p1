import 'dart:convert';
import 'package:juan_serna_9_2021_2_p1/models/response.dart';
import 'package:juan_serna_9_2021_2_p1/models/characters_potter.dart';
import 'constans.dart';
import 'package:http/http.dart' as http;


class ApiHelper{
  
  static Future<Response> getCharacters() async{
      var url = Uri.parse('${Constans.apiUrl}/api/characters');

      var response = await http.get(
        url,
        headers: {
          'content-type' : 'application/json',
          'accept' : 'application/json'//,
          //'authorization': 'bearer $token',
        },
      );

      var body = response.body;
      if(response.statusCode >= 400)
      {
        return Response(isSuccess: false, message: body);
      }

      List<CharactersHP> list = [];
      var decodedJson = jsonDecode(body);
      if(decodedJson != null)
      {
        for (var item in decodedJson) {
          list.add(CharactersHP.fromJson(item));
        }
      }

      return Response(isSuccess: true, result: list);
    }
}