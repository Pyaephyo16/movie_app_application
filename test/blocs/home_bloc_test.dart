import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/blocs/home_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Home Bloc Test",(){

    HomeBloc? homeBloc;

    setUp((){
      homeBloc = HomeBloc(movieModel: MovieModelImplMock());
    });


    test("Fetch Now Playing Movies Test",(){
      expect(
        homeBloc?.nowPlayingMovies?.contains(getMockMoviesForTest().first),
         true,
         );
    });


    test("Fetch Popular Movies Test", (){
      expect(
        homeBloc?.popularMovies?.contains(getMockMoviesForTest()[1]),
         true,
         );
    });

    
    test("Fetch Top Rated Movies Test",(){
      expect(
        homeBloc?.topRatedMovies?.contains(getMockMoviesForTest().last),
         true,
         );
    });


    test("Fetch Genres Test",(){
      expect(
        homeBloc?.genres?.contains(getMockGenres().first),
         true,
         );
    });


    test("Fetch Initial Movies By Genres Test",()async{
        await Future.delayed(Duration(milliseconds: 500));
        expect(
          homeBloc?.moviesByGenre?.contains(getMockMoviesForTest().first),
          true,
          );
       });


    test("Fetch Actors Test",(){
      expect(
        homeBloc?.actors?.contains(getMockActors().first),
         true,
         );
    });


    test("Fetch Movies By Genre By User", ()async{
        homeBloc?.onTapGenre(3);
        await Future.delayed(Duration(milliseconds: 500));
        expect(
          homeBloc?.moviesByGenre?.contains(getMockMoviesForTest().last),
           true,
           );
    });

  });

}