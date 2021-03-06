import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/movie_detail_bloc.dart';
import 'package:movie_app/data/data.vos/actor_vo.dart';
import 'package:movie_app/data/data.vos/movie_vo.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_and_horizontal_movie_list_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {

  final int movieId;

  MovieDetailPage({required this.movieId});

  // ///Model
  // MovieModel _movieModel = MovieModelImpl();
  // ///State Variables
  // MovieVO? movieDetails;
  // List<ActorVO>? cast;
  // List<ActorVO>? crew;
  // @override
  // void initState() {
  //   ///MovieDetails
  //   _movieModel.getMovieDetails(widget.movieId)
  //   .then((movieDetails){
  //     setState(() {
  //       this.movieDetails = movieDetails;
  //     });
  //   }).catchError((error){
  //     debugPrint("Movie Details Api Error ============> ${error.toString()}");
  //   });
  //   ///Movie Details Database
  //   _movieModel.getMovieDetailsFromDatabase(widget.movieId).then((movieDetails){
  //     setState(() {
  //       this.movieDetails = movieDetails;
  //     });
  //   });
  //   ///CreditsByMovie
  //   _movieModel.getCreditsByMovie(widget.movieId)
  //   .then((castAndCrew){
  //     setState(() {
  //       this.cast = castAndCrew.first;
  //       this.crew = castAndCrew[1];
  //     });
  //   }).catchError((error){
  //     debugPrint(error.toString());
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailBloc(movieId),
      child: Scaffold(
        body: Selector<MovieDetailBloc,MovieVO>(
          selector: (context,bloc) => bloc.movieDetails ?? MovieVO.emptySituation(),
          builder: (context, movie, child) => 
           Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: CustomScrollView(
              slivers: [
                MovieDetailSliverAppBarView(
                  () => Navigator.pop(context),
                 //movie: this.movieDetails,
                 movie: movie,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: TrailerSection(
                        // runTime: movieDetails?.getRuntimeString(movieDetails?.runTime ?? 0) ?? "",
                        // genreList: movieDetails?.getGenreListAsStringList() ?? [],
                        // storyLine : movieDetails?.overView ?? "",
                        runTime: movie.getRuntimeString(movie.runTime ?? 0),
                          genreList: movie.getGenreListAsStringList(),
                          storyLine: movie.overView ?? "",
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Selector<MovieDetailBloc,List<ActorVO>>(
                      selector: (context,bloc) => bloc.cast ?? [],
                      builder: (context,actorList,child) =>
                      (actorList !=null && actorList.isNotEmpty) ? ActorsAndCreatorsSectionView(
                        MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                        "",
                        seeMoreButtonVisibility: false,
                        //actors: this.cast,
                        actors: actorList,
                      ) : Container(),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                      child: AboutFilmSectionView(
                        //movieVO: movieDetails,
                        movieVO: movie,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    
                     Selector<MovieDetailBloc,List<ActorVO>>(
                       selector: (context,bloc) => bloc.crew ?? [],
                       builder: (context,creatorList,child) {
                    return  (creatorList !=null && creatorList.isNotEmpty) ? ActorsAndCreatorsSectionView(
                        MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                        MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                        //actors: this.crew,
                        actors: creatorList,
                      ) : Container();
                       }
                    ),
                    SizedBox(height: MARGIN_LARGE,),
                    Selector<MovieDetailBloc,List<MovieVO>?>(
                      selector: (context,bloc) => bloc.mRelatedMovies,
                      builder: (context,relatedMovies,child) =>
                       TitleAndHorizontalMovieListView(
                        (movieId) => _navigateToMovieDetailScreen(context, movieId),
                      nowPlayingMovies: relatedMovies,
                      title: MOVIE_DETAILS_SCREEN_RELATED_MOVIES,
                      onListEndReached: (){
                      },
                      ),
                    ),
                    SizedBox(height: MARGIN_LARGE,),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 void _navigateToMovieDetailScreen(BuildContext context, int? movieId) {
    if (movieId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailPage(
            movieId: movieId,
          ),
        ),
      );
    }
  }

}

class AboutFilmSectionView extends StatelessWidget {

  final MovieVO? movieVO;

  AboutFilmSectionView({required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Original Title",
          movieVO?.title ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Type",
         movieVO?.getGenreListAsCommaSeparatedString() ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Production",
          movieVO?.getProductionCountriesAsCommaSeparatedString() ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Premiere",
          movieVO?.releaseDate ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          "Description",
          movieVO?.overView ?? "",
        ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;

  AboutFilmInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
              color: MOVIE_DETAIL_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final String runTime;
  final List<String> genreList;
  final String storyLine;

  TrailerSection({required this.runTime,required this.genreList,required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(
            runTime: runTime,
            genreList: genreList
        ),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(
          storyLine: this.storyLine,
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: [
            MovieDetailScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailScreenButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        ),
      ],
    );
  }
}

class MovieDetailScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailScreenButtonView(this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border:
            (isGhostButton) ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {

  final String storyLine;

  StoryLineView({required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          storyLine,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  final String runTime;
  final List<String> genreList;

  MovieTimeAndGenreView({
    required this.runTime,
   required this.genreList,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          runTime,
          //"2h 30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
           ...genreList.map((genre) => GenreChipView(genre),).toList(),
      //  Spacer(),
        Icon(
          Icons.favorite_border_outlined,
          color: Colors.white,
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}

class MovieDetailSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movie;

  MovieDetailSliverAppBarView(this.onTapBack,{required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAIL_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: (movie?.posterPath == null) ? Container() : MovieDetailAppBarImageView(
                imageUrl: movie?.posterPath ?? "",
              ),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(
                  () => onTapBack(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                    right: MARGIN_MEDIUM_2,
                    bottom: MARGIN_LARGE),
                child: MovieDetailAppBarInfoView(
                  movie: this.movie,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailAppBarInfoView extends StatelessWidget {

  final MovieVO? movie;

  MovieDetailAppBarInfoView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailYearView(
              year: movie?.releaseDate?.substring(0,4) ?? "",
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(
                      movieRate: movie?.voteAverage ?? 0,
                    ),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText("${movie?.voteCount} VOTES"),
                    SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    ),
                  ],
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  movie?.voteAverage.toString() ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAIL_RATING_TEXT_SIZE,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          movie?.title ?? "",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class MovieDetailYearView extends StatelessWidget {

  final String? year;

  MovieDetailYearView({required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Center(
        child: Text(
          "2021",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
    print(MARGIN_XXLARGE + MARGIN_MEDIUM);
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

class MovieDetailAppBarImageView extends StatelessWidget {

 final String imageUrl;

 MovieDetailAppBarImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
      fit: BoxFit.cover,
    );
  }
}
