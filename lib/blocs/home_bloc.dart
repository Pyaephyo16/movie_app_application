import 'package:flutter/foundation.dart';
import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

class HomeBloc extends ChangeNotifier{

  ///State Variables
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenre;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  ///Model 
  MovieModel movieModel = MovieModelImpl();

  HomeBloc(){

      ///Now Playing Movies
    // movieModel.getNowPlayingMovies().then((movieList) {
    //   setState(() {
    //     nowPlayingMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    ///Now Playing Movies Database
    movieModel.getNowPlayingMoviesFromDatabase().listen((movieList){
        nowPlayingMovies = movieList;
        notifyListeners();
    }).onError((error){
      debugPrint(error.toString());
    });

    ///Popular Movies
    // movieModel.getPopularMovies().then((movieList) {
    //   setState(() {
    //     popularMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    ///Popular Movies Database
    movieModel.getPopularMoviesFromDatabase().listen((movieList){
        popularMovies = movieList;
      notifyListeners();
    }).onError((error){
      debugPrint(error.toString());
    });

    ///Top Rated Movies
    // movieModel.getNowPlayingMovies().then((movieList) {
    //   setState(() {
    //     topRatedMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    ///Top Rated Movies Database
    movieModel.getTopRatedMoviesFromDatabase().listen((movieList){
        topRatedMovies = movieList;
      notifyListeners();
    }).onError((error){
      debugPrint(error.toString());
    });

    ///Genres
    movieModel.getGenres().then((genres) {
        this.genres = genres;
        ///Movies By Genre
        _getMoviesByGenreAndRefresh(genres?.first.id ?? 0);
       
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Genres Database
    movieModel.getGenresFromDatabase().then((genres){
        this.genres = genres;
        ///Movies By Genre Database
        _getMoviesByGenreAndRefresh(genres?.first.id ?? 0);       

    }).catchError((error){
      debugPrint(error.toString());
    });

    ///Actors
    movieModel.getActors(1).then((actors) {
        this.actors = actors;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Actors Database
    movieModel.getActorsFromDatabase().then((actors){
        this.actors = actors;
      notifyListeners();
    }).catchError((error){
      debugPrint(error.toString());
    });

  }

    void onTapGenre(int genreId){
      _getMoviesByGenreAndRefresh(genreId);
    }

   void _getMoviesByGenreAndRefresh(int genreId){
    movieModel.getMoviesByGenre(genreId).then((moviesByGenre){
        this.moviesByGenre = moviesByGenre;
      notifyListeners();
    }).catchError((error){
      debugPrint(error.toString());
    });
  }
  

}