import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';

abstract class MovieModel{

  ///Network
  Future<List<MovieVO>?> getNowPlayingMovies();
  Future<List<MovieVO>?> getPopularMovies();
  Future<List<MovieVO>?> getTopRatedMovies();
  Future<List<GenreVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  ///Database
  Future<List<MovieVO>?> getTopRatedMoviesFromDatabase();
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  Future<List<MovieVO>?> getPopularMoviesFromDatabase();
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getActorsFromDatabase();
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId);
}