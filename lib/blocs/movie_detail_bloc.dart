import 'package:flutter/foundation.dart';
import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

class MovieDetailBloc extends ChangeNotifier{

  ///State Variables
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;
  List<MovieVO>? mRelatedMovies;

  //Model
  MovieModel _movieModel = MovieModelImpl();

  MovieDetailBloc(int movieId){

      ///MovieDetails
    _movieModel.getMovieDetails(movieId)
    .then((movieDetails){
        this.movieDetails = movieDetails;
      notifyListeners();
    }).catchError((error){
      debugPrint("Movie Details Api Error ============> ${error.toString()}");
    });

    ///Movie Details Database
    _movieModel.getMovieDetailsFromDatabase(movieId).then((movie){
        movieDetails = movie;
        getRelatedMovies(movie?.genreIds?.first ?? 0);
        //getRelatedMovies(movie?.genres?.first.id ?? 0);
     notifyListeners();
    });

    ///CreditsByMovie
    _movieModel.getCreditsByMovie(movieId)
    .then((castAndCrew){
        this.cast = castAndCrew.first;
        this.crew = castAndCrew[1];
     notifyListeners();
    }).catchError((error){
      debugPrint(error.toString());
    });

  }

  void getRelatedMovies(int genreId){
    _movieModel.getMoviesByGenre(genreId).then((relatedMovies){
        mRelatedMovies = relatedMovies;
        notifyListeners();
    });
  }

}