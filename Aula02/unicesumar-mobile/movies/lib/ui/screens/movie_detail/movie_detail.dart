import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:movies/models/movie_credits.dart';
import 'package:movies/models/favorite.dart';

import 'package:movies/models/movie_details.dart';
import 'package:movies/models/movie_videos.dart';
import 'package:movies/providers.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:movies/ui/theme/theme.dart';
import 'package:movies/ui/widgets/horiz_cast.dart';
import 'package:movies/ui/widgets/not_ready.dart';
import 'package:movies/ui/screens/movie_detail/button_row.dart';
import 'package:movies/ui/screens/movie_detail/detail_image.dart';
import 'package:movies/ui/screens/movie_detail/genre_row.dart';
import 'package:movies/ui/screens/movie_detail/movie_overview.dart';
import 'package:movies/ui/screens/movie_detail/trailer.dart';

@RoutePage(name: 'MovieDetailRoute')
class MovieDetail extends ConsumerStatefulWidget {
  final int movieId;

  const MovieDetail(@PathParam('movieId') this.movieId, {super.key});

  @override
  ConsumerState<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends ConsumerState<MovieDetail> {
  final favoriteNotifier = ValueNotifier<bool>(false);
  late MovieViewModel movieViewModel;
  MovieCredits? credits;
  MovieVideos? movieVideos;

  @override
  Widget build(BuildContext context) {
    final movieViewModelAsync = ref.watch(movieViewModelProvider);
    return movieViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        movieViewModel = viewModel;
        return buildScreen();
      },
    );
  }

  Widget buildScreen() {
    final isDarkMode = ref.watch(themeProvider);
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const NotReady();
          }
          if (snapshot.hasError) {
            logMessage('Error: ${snapshot.error.toString()}');
            return Text(snapshot.error.toString());
          }
          final movieDetails = snapshot.data as MovieDetails?;
          if (movieDetails == null) {
            return const NotReady();
          }
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor:
                    isDarkMode ? const Color(0xFF111111) : Colors.white,
                leading: BackButton(
                  color: isDarkMode ? Colors.white : Colors.black,
                  onPressed: () {
                    context.router.maybePopTop();
                  },
                ),
                centerTitle: false,
                title: Text('Back',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              body: Container(
                color: isDarkMode ? const Color(0xFF111111) : Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CustomScrollView(slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Stack(
                                children: [DetailImage(details: movieDetails)]),
                            GenreRow(genres: movieDetails.genres),
                            MovieOverview(details: movieDetails),
                            ValueListenableBuilder<bool>(
                              valueListenable: favoriteNotifier,
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return ButtonRow(
                                  favoriteSelected: favoriteNotifier.value,
                                  onFavoriteSelected: () async {
                                    if (favoriteNotifier.value) {
                                      // ✅ desfavoritar — remove do banco
                                      await movieViewModel
                                          .removeFavorite(widget.movieId);
                                      favoriteNotifier.value = false;
                                    } else {
                                      // ✅ favoritar — salva no banco
                                      final details =
                                          snapshot.data as MovieDetails;
                                      await movieViewModel.saveFavorite(
                                        Favorite(
                                          movieId: details.id,
                                          image: details.posterPath,
                                          favorite: true,
                                          title: details.title,
                                          overview: details.overview,
                                          popularity: details.popularity,
                                          releaseDate: details.releaseDate,
                                        ),
                                        details,
                                      );
                                      favoriteNotifier.value = true;
                                    }
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, bottom: 8),
                              child: Text('Trailers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
                            ),
                            Trailer(
                              movieVideos: movieVideos?.results,
                              onVideoTap: (video) {
                                context.router
                                    .push(VideoPageRoute(movieVideo: video));
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, top: 16),
                              child: Text('Cast',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
                            ),
                          ]),
                        ),
                        HorizontalCast(castList: credits?.cast ?? []),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future loadData() async {
    credits = await movieViewModel.getMovieCredits(widget.movieId);
    movieVideos = await movieViewModel.getMovieVideos(widget.movieId);
    return movieViewModel.getMovieDetails(widget.movieId);
  }
}
