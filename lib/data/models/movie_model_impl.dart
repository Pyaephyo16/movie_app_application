import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/network/dataagents/movie_data_agents.dart';
import 'package:movie_app/network/dataagents/retrofit_data_agents_impl.dart';
import 'package:movie_app/persistance/abstraction_layer/actor_dao.dart';
import 'package:movie_app/persistance/abstraction_layer/genre_dao.dart';
import 'package:movie_app/persistance/abstraction_layer/movie_dao.dart';
import 'package:movie_app/persistance/daos/actor_dao_impl.dart';
import 'package:movie_app/persistance/daos/genre_dao_impl.dart';
import 'package:movie_app/persistance/daos/movie_dao_impl.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel{

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }

  MovieModelImpl._internal();

  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  ///Dao
  MovieDao mMovieDao = MovieDaoImpl();
  GenreDao mGenreDao = GenreDaoImpl();
  ActorDao mActorDao = ActorDaoImpl();

  ///For Testing Purpose
  void setDaosAndDataAgents(
    MovieDao movieDao,
    ActorDao actorDao,
    GenreDao genreDao,
    MovieDataAgent dataAgent,
    ){
    mMovieDao = movieDao;
    mGenreDao = genreDao;
    mActorDao = actorDao;
    mDataAgent = dataAgent;
  }


  ///Network
  @override
  void getNowPlayingMovies(int page) {
    mDataAgent.getNowPlayingMovies(page).then((movies){
        List<MovieVO> nowPlayingMovies = movies?.map((movie){
          movie.isNowPlaying = true;
          movie.isPopular = false;
          movie.isTopRated = false;
          return movie;
        }).toList() ?? [];
        mMovieDao.saveMovies(nowPlayingMovies);
       //return Future.value(movies);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mDataAgent.getActors(1).then((actors){
      mActorDao.saveAllActors(actors ?? []);
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mDataAgent.getGenres().then((genres) {
        mGenreDao.saveAllGenres(genres ?? []);
        return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  void getPopularMovies(int page) {
     mDataAgent.getPopularMovies(page).then((movies){
      List<MovieVO> popularMovies = movies?.map((movie){
          movie.isNowPlaying = false;
          movie.isPopular = true;
          movie.isTopRated = false;
          return movie;
      }).toList() ?? [];
      mMovieDao.saveMovies(popularMovies);
      //return Future.value(movies);
    });
  }

  @override
  void getTopRatedMovies(int page) {
   mDataAgent.getTopRatedMovies(page).then((movies){
        List<MovieVO> topRatedMovies = movies?.map((movie) {
          movie.isNowPlaying = false;
          movie.isPopular = false;
          movie.isTopRated = true;
          return movie;
        }).toList() ?? [];
        mMovieDao.saveMovies(topRatedMovies);
       // return Future.value(movies);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
      return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
      return mDataAgent.getMovieDetails(movieId).then((movie){
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
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    // return Future.value(
    //   mMovieDao.getAllMovies()
    //       .where((movies) {
    //         return movies.isNowPlaying ?? true;
    //   }).toList());
      this.getNowPlayingMovies(1);
      return mMovieDao
      .getAllMoviesEventStream()
      .startWith(mMovieDao.getNowPlayingMoviesStream())
      .map((event) => mMovieDao.getNowPlayingMovies(),);
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
      // return Future.value(
      //     mMovieDao.getAllMovies()
      //         .where((movies) => movies.isPopular ?? true )
      //         .toList());
      this.getPopularMovies(1);
      return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies(),);
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase() {
      // return Future.value(
      //   mMovieDao.getAllMovies()
      //       .where((movies) => movies.isTopRated ?? true )
      //       .toList());
     this.getTopRatedMovies(1);
      return mMovieDao
      .getAllMoviesEventStream()
      .startWith(mMovieDao.getTopRatedMoviesStream())
      .map((event) => mMovieDao.getTopRatedMovies()); 
       
  }

}