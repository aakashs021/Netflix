import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:netflix/apikey.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/models/vedio.dart';

class Api {
  static const videoList = [
    "Nv5r7-p9l44",
    "qOFSk7SsPls",
    "EclwoVfNgOA",
    "tZ4gg-UAgC8",
    "kZVLxyCwSDI",
    "o7FGXxT9mng",
    "KXVi1uw8ZWk",
    "mVR1-NfiLDk",
    "uYKqxzJjqAQ",
    "r_mI-_Wb-9Y",
    "HK7q3njG2og",
    "BymU072rUV8",
    "yfk8ak1rKIM"
  ];
  static const ratedurl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey';
  static const trendurl =
      'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';
  static const upcomingurl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$apikey';
  static const imageurl = 'https://image.tmdb.org/t/p/w500';
  static const discoverurl =
      'https://api.themoviedb.org/3/discover/movie?api_key=$apikey';
  static const nowplayingurl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';

  Future<List<Movies>> fetchMovies(String url) async {
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final List moviesList = decodedData['results'];
        return moviesList.map((movie) => Movies.fromJson(json: movie)).toList();
      } else {
        throw HttpException(
            'Failed to load movies, status code: ${response.statusCode}');
      }
    } on SocketException {
      throw 'No Internet connection 😑';
    } on HttpException {
      throw 'Couldn\'t find the movies 😱';
    } on FormatException {
      throw 'Bad response format 👎';
    } on TimeoutException {
      throw 'Request timed out. Please try again later.';
    } catch (e) {
      return fetchMovies(url);
    }
  }

  Future<List<Movies>> getupcomingmovies() async {
    return fetchMovies(upcomingurl);
  }

  Future<List<Movies>> gettrendingmovies() async {
    return fetchMovies(trendurl);
  }

  Future<List<Movies>> gettopratedmovies() async {
    return fetchMovies(ratedurl);
  }

  Future<List<Movies>> getdicovermovies() async {
    return fetchMovies(discoverurl);
  }

  Future<List<Movies>> getnowplayingmovies() async {
    return fetchMovies(nowplayingurl);
  }

  Future<String?> getvideourl(int id) async {
    return fetchvideo(id);
  }

  Future<List<Movies>> getrecommendedmovies({required int id}) async {
    final String recommendedurl =
        'https://api.themoviedb.org/3/movie/$id/recommendations?api_key=$apikey';
    return fetchMovies(recommendedurl);
  }

  Future<String?> fetchvideo(int id) async {
    try {
      final String videourl =
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=$apikey';
      final response = await http.get(Uri.parse(videourl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        List<dynamic> videosList = decodedData['results'];
        for (var item in videosList) {
          Vedio video = Vedio.fromJson(json: item);
          if (video.type == 'Trailer') {
            return video.key;
          }
        }
      } else {
        throw HttpException(
            'Failed to load videos, status code: ${response.statusCode}');
      }
      return null;
    } on TimeoutException {
      throw 'Request timed out. Please try again later.';
    } catch (e) {
      return fetchvideo(id);
    }
  }

  Future<List<Movies>> fetchbysearch({required String name}) async {
    try {
      final searchurl =
          'https://api.themoviedb.org/3/search/movie?query=$name&api_key=$apikey';
      final response = await http.get(Uri.parse(searchurl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData['results'] != null) {
          List<dynamic> moviesList = decodedData['results'];
          return moviesList
              .map((movie) => Movies.fromJson(json: movie))
              .toList();
        } else {
          return [];
        }
      } else {
        throw HttpException(
            'Failed to load movies, status code: ${response.statusCode}');
      }
    } on TimeoutException {
      throw 'Request timed out. Please try again later.';
    } catch (e) {
      throw 'Unexpected error 😢: $e';
    }
  }
}
