import 'package:netflix/models/movies.dart';

Future<List<Movies>> retryFetchMovies(
      Future<List<Movies>> Function() fetchMovies,
      {int retries = 3}) async {
    int attempt = 0;
    while (attempt < retries) {
      try {
        return await fetchMovies();
      } catch (e) {
        if (attempt == retries - 1) {
          rethrow;
        }
        attempt++;
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    throw 'Failed to fetch movies after $retries attempts';
  }