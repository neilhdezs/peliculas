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

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    final nowPlayingResponse = NowPlayingResponses.fromJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;

    //print(nowPlayingResponse.results);

    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    final nowPopularResponse = PopularResponses.fromJson(response.body);

    popularMovies = [...popularMovies, ...nowPopularResponse.results];

    //print( popularMovies[0] );

    //print(nowPopularResponse.results);

    notifyListeners();
  }
}
