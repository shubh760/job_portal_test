import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> get(String url) {
    return http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        log(response.reasonPhrase.toString());
        throw Exception('Error: ${response.statusCode}');
      }
    });
  }
}
