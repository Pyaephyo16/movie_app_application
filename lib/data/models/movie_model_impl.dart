import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/network/dataagents/movie_data_agents.dart';
import 'package:movie_app/network/dataagents/retrofit_data_agents_impl.dart';
import 'package:movie_app/persistance/daos/actor_dao.dart';
import 'package:movie_app/persistance/daos/genre_dao.dart';
import 'package:movie_app/persistance/daos/movie_dao.dart';

class MovieModelImpl extends MovieModel{

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }

  MovieModelImpl._internal();

  MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  ///Dao
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();


  ///Network
  @override
  Future<List<MovieVO>?> getNowPlayingMovies() {
    return _dataAgent.getNowPlayingMovies(1).then((movies)async{
        List<MovieVO> nowPlayingMovies = movies?.map((movie){
          movie.isNowPlaying = true;
          movie.isPopular = false;
          movie.isTopRated = false;
          return movie;
        }).toList() ?? [];
        mMovieDao.saveMovies(nowPlayingMovies);
        return Future.value(movies);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(1).then((actors)async{
      mActorDao.saveAllActors(actors ?? []);
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres().then((genres)async {
        mGenreDao.saveAllGenres(genres ?? []);
        return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>?> getPopularMovies() {
    return _dataAgent.getPopularMovies(1).then((movies)async{
      List<MovieVO> popularMovies = movies?.map((movie){
          movie.isNowPlaying = false;
          movie.isPopular = true;
          movie.isTopRated = false;
          return movie;
      }).toList() ?? [];
      mMovieDao.saveMovies(popularMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies() {
    return _dataAgent.getTopRatedMovies(1).then((movies)async{
        List<MovieVO> topRatedMovies = movies?.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = false;
          movie.isTopRated = true;
          return movie;
        }).toList() ?? [];
        mMovieDao.saveMovies(topRatedMovies);
        return Future.value(movies);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
      return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
      return _dataAgent.getMovieDetails(movieId).then((movie)async{
          mMovieDao.saveSingleMovie(movie!);
          return Future.value(movie);
      });
  }

  ///Database
  @override
  Future<List<ActorVO>?> getActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
      return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Future.value(
      mMovieDao.getAllMovies()
          .where((movies) {
            return movies.isNowPlaying ?? true;
      }).toList());
  }

  @override
  Future<List<MovieVO>?> getPopularMoviesFromDatabase() {
      return Future.value(
          mMovieDao.getAllMovies()
              .where((movies) => movies.isPopular ?? true )
              .toList());
  }

  @override
  Future<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
      return Future.value(
        mMovieDao.getAllMovies()
            .where((movies) => movies.isTopRated ?? true )
            .toList());
  }
}