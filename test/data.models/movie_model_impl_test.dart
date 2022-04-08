import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agents_impl_mock.dart';
import '../persistance/actor_dao_impl_mock.dart';
import '../persistance/genre_dao_impl_mock.dart';
import '../persistance/movie_dao_impl_mock.dart';

void main(){

  group("movie_model_impl", (){

      var movieModel = MovieModelImpl();

    setUp((){
      movieModel.setDaosAndDataAgents(
        MovieDaoImplMock(),
        ActorDaoImplMock(),
        GenreDaoImplMock(),
        MovieDataAgentsImplMock(),
        );
    });

    test("Saving Now Playing Movies And Getting Now Playing Movies From Database", 
    (){
      expect(
        movieModel.getNowPlayingMoviesFromDatabase(), 
      emits(
        [
          MovieVO(
        false, 
        "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
         [
           16,
           10751,
            35,
            14,
            ],
          508947, 
          "en",
           "Turning Red", 
          "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
           5329.202,
           "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
           "2022-03-01",
           "Turning Red", 
           false,
           7.5,
           1433,
           null,
           null,
           null,
           null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null, 
            true,
            false,
            false,
        ),
        ]
      ),
      );
    });


    test("Saving Popular Movies and Getting Popular Movies From Database",
    (){
      expect(
        movieModel.getPopularMoviesFromDatabase(),
        emits(
          [
        MovieVO(
        false, 
        "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
         [
                28,
                12,
                878 
            ],
          634649, 
          "en",
           "Spider-Man: No Way Home", 
          "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
           6064.019,
           "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
           "2021-12-15",
           "Spider-Man: No Way Home", 
           false,
           8.2,
           11022,
           null,
           null,
           null,
           null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null, 
            false,
            true,
            false,
        ),
          ]
        ),
        );
      }
    );


    test("Saving Top Rated Movies and Getting Top Rated Movies From Database",
     (){
       expect(
         movieModel.getTopRatedMoviesFromDatabase(),
          emits([
   MovieVO(
        false, 
        "/wPU78OPN4BYEgWYdXyg0phMee64.jpg",
         [
                18,
                80
            ],
          278, 
          "en",
          "The Shawshank Redemption", 
          "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
           78.147,
           "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
           "1994-09-23",
           "The Shawshank Redemption", 
           false,
           8.7,
           21091,
           null,
           null,
           null,
           null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null, 
            false,
            false,
            true,
        ),    
          ])
          );
     }
     );


    test("Get Genres", (){
      expect(
        movieModel.getGenres(),
         completion(
           equals(getMockGenres()),
         )
         );
    });


    test("Get Actors Test", (){
      expect(
        movieModel.getActors(1),
         completion(
           equals(getMockActors()),
         )
         );
    });


    test("Get Credits By Movie Test",(){
        expect(
          movieModel.getCreditsByMovie(1),
          completion(
            equals(getMockCredits()),
          )
           );
    });


    test("Get Movie Details Test",(){
      expect(
        movieModel.getMovieDetails(1),
        completion(
          equals(getMockMoviesForTest().first),
        )
         );
    });


    test("Get Actors From Database",()async{
      await movieModel.getActors(1);
        expect(
          movieModel.getActorsFromDatabase(), 
          completion(
            equals(getMockActors()),
          )
          );
    });


    test("Get Movie Details From Database Test",()async{
        await movieModel.getMovieDetails(1);
        expect(
          movieModel.getMovieDetails(1),
            completion(
              equals(getMockMoviesForTest().first),
            )
           );
    });


    test("Get Genres From Databaase Test",()async{
        await movieModel.getGenres();
        expect(
          movieModel.getGenresFromDatabase(),
           completion(
             equals(getMockGenres()),
           )
           );
    });

  });

}