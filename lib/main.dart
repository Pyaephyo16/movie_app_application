import 'package:flutter/material.dart';
import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/collection_vo.dart';
import 'package:movie_app/data/data.vos/date_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/data.vos/production_company_vo.dart';
import 'package:movie_app/data/data.vos/production_country_vo.dart';
import 'package:movie_app/data/data.vos/spoken_language_vo.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/network/dataagents/dio_movie_data_agents_impl.dart';
import 'package:movie_app/network/dataagents/http_movie_data_agents_impl.dart';
import 'package:movie_app/network/dataagents/retrofit_data_agents_impl.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/persistance/hive_constants.dart';

void main()async {

  await Hive.initFlutter();

Hive.registerAdapter(ActorVOAdapter());
//Hive.registerAdapter(BaseActorVOAdapter());
Hive.registerAdapter(CollectionVOAdapter());
//Hive.registerAdapter(CreditVOAdapter());
Hive.registerAdapter(DateVOAdapter());
Hive.registerAdapter(GenreVOAdapter());
Hive.registerAdapter(MovieVOAdapter());
Hive.registerAdapter(ProductionCompanyVOAdapter());
Hive.registerAdapter(ProductionCountryVOAdapter());
Hive.registerAdapter(SpokenLanguageVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  
  runApp(
      MyApp(),
  );
  print(MovieModelImpl().getNowPlayingMoviesFromDatabase().runtimeType);
}

   

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
     //   visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

