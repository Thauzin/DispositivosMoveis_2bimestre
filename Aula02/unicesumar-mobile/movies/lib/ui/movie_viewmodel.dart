import 'package:lumberdash/lumberdash.dart';
import 'package:movies/data/database_interface.dart';
import 'package:movies/data/drift/movie_database.dart';
import 'package:movies/models/favorite.dart';         
import 'package:movies/models/genre.dart';         
import 'package:movies/data/models/database_models.dart'; 
import 'package:movies/models/movie_credits.dart';
import 'package:movies/models/movie_details.dart';
import 'package:movies/models/movie_response.dart';
import 'package:movies/models/movie_results.dart';
import 'package:movies/models/movie_videos.dart';
import 'package:movies/network/movie_api_service.dart';
import 'package:movies/utils/utils.dart';

class MovieViewModel {
  final MovieAPIService movieAPIService;
  final IDatabase database = DriftDatabase();

  List<Genre>? movieGenres;
  List<MovieResults> trendingMovies = [];
  List<MovieResults> topRatedMovies = [];
  List<MovieResults> popularMovies = [];
  List<MovieResults> nowPlayingMovies = [];

  MovieViewModel({required this.movieAPIService});

  Future setup() async {
    await Future.wait([setupConfiguration(), setupGenres()]);
  }

  Future setupConfiguration() async {}

  Future setupGenres() async {
    final response = await movieAPIService.getGenres();
    if (response.statusCode == 200) {
      movieGenres = Genres.fromJson(response.data).genres;
    } else {
      logError(
          'Failed to load genres with error ${response.statusCode} and message ${response.statusMessage}');
    }
  }

  Stream<List<Favorite>> streamFavorites() {
    return database.streamFavorites().map((dbFavorites) =>
        dbFavorites.map((f) => Favorite(
              movieId: f.movieId,
              image: getImageUrl(ImageSize.large, f.posterPath),
              favorite: f.favorite,
              title: f.title,
              overview: f.overview,
              popularity: f.popularity,
              releaseDate: f.releaseDate,
            )).toList());
  }

  Future<void> saveFavorite(Favorite favorite, MovieDetails details) async {
    await database.saveFavorite(DBFavorite(
      id: 0,
      movieId: favorite.movieId,
      backdropPath: details.backdropPath,
      posterPath: details.posterPath,
      favorite: true,
      popularity: favorite.popularity,
      releaseDate: favorite.releaseDate,
      title: favorite.title,
      overview: favorite.overview,
    ));
  }

  Future<void> removeFavorite(int movieId) async {
    await database.removeFavorite(movieId);
  }

  void updateFavorite(Favorite favorite) {}

  Future<MovieResponse?> getTrendingMovies(int page) async {
    final response = await movieAPIService.getTrending(page);
    if (response.statusCode == 200) {
      var movieResponse = MovieResponse.fromJson(response.data);
      trendingMovies = movieResponse.results;
      return movieResponse;
    } else {
      logError(
          'Failed to load movies with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }

  Future<MovieResponse?> getPopular(int page) async {
    final response = await movieAPIService.getPopular(page);
    if (response.statusCode == 200) {
      var movieResponse = MovieResponse.fromJson(response.data);
      popularMovies = movieResponse.results;
      return movieResponse;
    } else {
      logError(
          'Failed to load movies with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }

  Future<MovieResponse?> getTopRated(int page) async {
    final response = await movieAPIService.getTopRated(page);
    if (response.statusCode == 200) {
      var movieResponse = MovieResponse.fromJson(response.data);
      topRatedMovies = movieResponse.results;
      return movieResponse;
    } else {
      logError(
          'Failed to load movies with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }

  Future<MovieResponse?> getNowPlaying(int page) async {
    final response = await movieAPIService.getNowPlaying(page);
    if (response.statusCode == 200) {
      var movieResponse = MovieResponse.fromJson(response.data);
      nowPlayingMovies = movieResponse.results;
      return movieResponse;
    } else {
      logError(
          'Failed to load movies with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }

  Future<MovieDetails?> getMovieDetails(int movieId) async {
    final response = await movieAPIService.getMovieDetails(movieId);
    if (response.statusCode == 200) {
      try {
        return MovieDetails.fromJson(response.data);
      } catch (e) {
        logError('Failed to parse movie details with error $e');
        return null;
      }
    } else {
      logError(
          'Failed to load movie details with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }

  Future<MovieVideos?> getMovieVideos(int movieId) async {
    final response = await movieAPIService.getMovieVideos(movieId);
    if (response.statusCode == 200) {
      try {
        return MovieVideos.fromJson(response.data);
      } catch (e) {
        logError('Failed to parse movie videos with error $e');
        return null;
      }
    } else {
      logError(
          'Failed to load movie videos with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }

  Future<MovieCredits?> getMovieCredits(int movieId) async {
    final response = await movieAPIService.getMovieCredits(movieId);
    if (response.statusCode == 200) {
      try {
        return MovieCredits.fromJson(response.data);
      } catch (e) {
        logError('Failed to parse movie credits with error $e');
        return null;
      }
    } else {
      logError(
          'Failed to load movie credits with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }

  Future<MovieResponse?> searchMoviesByGenre(String genres, int page) async {
    final response = await movieAPIService.searchMoviesByGenre(genres, page);
    if (response.statusCode == 200) {
      var movieResponse = MovieResponse.fromJson(response.data);
      return movieResponse;
    } else {
      logError(
          'Failed to load movies with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }

  Future<MovieResponse?> searchMovies(String searchText, int page) async {
    final response = await movieAPIService.searchMovies(searchText, page);
    if (response.statusCode == 200) {
      var movieResponse = MovieResponse.fromJson(response.data);
      return movieResponse;
    } else {
      logError(
          'Failed to load movies with error ${response.statusCode} and message ${response.statusMessage}');
      return null;
    }
  }
}