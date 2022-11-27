import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:peliculas/models/now_playin_responses.dart';
import 'package:peliculas/models/popular-response.dart';
import 'package:peliculas/models/search_movie.dart';

import '../models/credits_response.dart';
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "57b768579acb56e6c5ddb5836c5e31a6";
  final String _language = "es-ES";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};
  List<Movie> searchMovies = [];

  int _popularPage = 0;
  int _displayPage = 0;
  String ultimaQuery = '';

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    _displayPage++;
    final jsonData = await _getJsonData('3/movie/now_playing', _displayPage);

    final nowPlayingResponse = NowPlayingResponses.fromJson(jsonData);

    onDisplayMovies = [...onDisplayMovies, ...nowPlayingResponse.results];

    //print(nowPlayingResponse.results);

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final nowPopularResponse = PopularResponses.fromJson(jsonData);

    popularMovies = [...popularMovies, ...nowPopularResponse.results];

    //print( popularMovies[0] );

    //print(nowPopularResponse.results);

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    if (query != ultimaQuery) {
      var url = Uri.https(
          _baseUrl, '3/search/movie', {'api_key': _apiKey, 'query': query});

      final response = await http.get(url);
      final searchMovie = SearchMovie.fromJson(response.body);
      searchMovies = searchMovie.results;
    }

    return searchMovies;
  }
}
