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

  ///Page
  int pageForNowPlayingMovies = 1;

  ///Model 
  MovieModel mMovieModel = MovieModelImpl();


  HomeBloc({MovieModel? movieModel}){

    if(movieModel != null){
      ///Set Mock Model For Test Dao
      mMovieModel = movieModel;
    }
    

      ///Now Playing Movies
    // movieModel.getNowPlayingMovies().then((movieList) {
    //   setState(() {
    //     nowPlayingMovies = movieList;
    //   });
    // }).catchError((error) {
    //   debugPrint(error.toString());
    // });

    ///Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList){
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
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList){
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
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList){
        topRatedMovies = movieList;
      notifyListeners();
    }).onError((error){
      debugPrint(error.toString());
    });

    ///Genres
    mMovieModel.getGenres().then((genres) {
        this.genres = genres;
        ///Movies By Genre
        _getMoviesByGenreAndRefresh(genres?.first.id ?? 0);
       
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Genres Database
    mMovieModel.getGenresFromDatabase().then((genres){
        this.genres = genres;
        ///Movies By Genre Database
        if(genres?.isNotEmpty ?? false){
          _getMoviesByGenreAndRefresh(genres?.first.id ?? 0);
        }       

    }).catchError((error){
      debugPrint(error.toString());
    });

    ///Actors
    mMovieModel.getActors(1).then((actors) {
        this.actors = actors;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Actors Database
    mMovieModel.getActorsFromDatabase().then((actors){
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
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre){
        this.moviesByGenre = moviesByGenre;
      notifyListeners();
    }).catchError((error){
      debugPrint(error.toString());
    });
  }

  void onNowPlayingMovieListEndReached(){
    this.pageForNowPlayingMovies += 1;
    mMovieModel.getNowPlayingMovies(pageForNowPlayingMovies);
  }
  

}