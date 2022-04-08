import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/collection_vo.dart';
import 'package:movie_app/data/data.vos/date_vo.dart';
import 'package:movie_app/data/data.vos/genre_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/data.vos/production_company_vo.dart';
import 'package:movie_app/data/data.vos/production_country_vo.dart';
import 'package:movie_app/data/data.vos/spoken_language_vo.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/persistance/hive_constants.dart';

import 'test_data/test_data.dart';

void main()async{

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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


 testWidgets("Tap Best Popular Movies And Nevigate To Details",
  (WidgetTester tester)async{

    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));

    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(HomePage), findsOneWidget);

    expect(find.text(TEST_DATA_MOVIE_NAME),findsOneWidget);

    await tester.tap(find.text(TEST_DATA_MOVIE_NAME));

    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);
    expect(find.text(TEST_DATA_RELEASE_YEAR), findsOneWidget);
    expect(find.text(TEST_DATA_RATING), findsOneWidget);

  }
 );

}