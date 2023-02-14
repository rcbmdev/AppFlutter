import 'package:http/http.dart' as http;
import 'dart:convert';

class RestUtil {
  static String urlBase = 'financasflask7.herokuapp.com'; //127.0.0.1:5000

  static Future<http.Response> addData(String uri, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.https(urlBase, uri),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data),
    );
    return response;
  }

  static Future<http.Response> getData(String uri) async {
    final response = await http.get(
      Uri.https(urlBase, uri)
    );
    return response;
  }

  static Future<http.Response> getDataId(String uri, String id) async {
    final response = await http.get(
      Uri.https(urlBase, uri + '/'+id),
    );
    return response;
  }

  static Future<http.Response> removeDataId(String uri, String id) async {
    final response = await http.delete(
      Uri.https(urlBase, uri + '/' +id)
    );
    return response;
  }

  static Future<http.Response> editData(String uri, Map<String, dynamic> data, String id) async{
    final response = await http.put(
      Uri.https(urlBase, uri+'/'+id),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data),
    );
    return response;
  }




}