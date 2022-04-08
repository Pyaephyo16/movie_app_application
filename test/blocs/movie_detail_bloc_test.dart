import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/blocs/movie_detail_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Movie Details Bloc Test",(){

      MovieDetailBloc? movieDetailsBloc;

      setUp((){
        movieDetailsBloc = MovieDetailBloc(1,movieModel: MovieModelImplMock());
      });


      test("Fetch Movies Details Test",(){
        expect(
          movieDetailsBloc?.movieDetails,
           getMockMoviesForTest().first,
           );
      });


      test("Fetch Creators Test",(){
        expect(
          movieDetailsBloc?.crew?.contains(getMockCredits().last[1]), 
          true,
          );
      });


      test("Fetch Actors Test", (){
        expect(
          movieDetailsBloc?.cast?.contains(getMockCredits().first.first),
          true,
           );
      });


      test("Related Movies Test",()async{
          movieDetailsBloc?.getRelatedMovies(2);
          await Future.delayed(Duration(milliseconds: 500));
        expect(
          movieDetailsBloc?.mRelatedMovies?.contains(getMockMoviesForTest().first),
          true,
           );
      });

  });

}