import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = "api.themoviedb.org";
  String _apiKey = "57b768579acb56e6c5ddb5836c5e31a6";
  String _language = "es-ES";

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    final Map<String, dynamic> decodedData = jsonDecode(response.body);

    print(response.body);
  }
}
