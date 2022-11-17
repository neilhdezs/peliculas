import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:peliculas/models/now_playin_responses.dart';
import 'package:peliculas/models/popular-response.dart';

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "57b768579acb56e6c5ddb5836c5e31a6";
  final String _language = "es-ES";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponses.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    //print(nowPlayingResponse.results);

    notifyListeners();
  }

  getPopularMovies() async {

    popularPage++;

    final jsonData = await _getJsonData('3/movie/now_playing', popularPage);

    final nowPopularResponse = PopularResponses.fromJson(jsonData);

    popularMovies = [...popularMovies, ...nowPopularResponse.results];

    //print( popularMovies[0] );

    //print(nowPopularResponse.results);

    notifyListeners();
  }
}
