import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/router/app_routes.dart';

import 'package:movies/models/movie.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/movie_viewmodel.dart';
import 'package:movies/ui/widgets/not_ready.dart';
import 'package:movies/ui/widgets/sliver_divider.dart';
import 'package:movies/ui/widgets/vert_movie_list.dart';
import 'package:movies/ui/screens/genres/genre_search_row.dart';
import 'package:movies/ui/screens/genres/genre_section.dart';
import 'package:movies/ui/screens/genres/sort_picker.dart';
import 'package:movies/utils/prefs.dart';
import 'package:movies/utils/utils.dart';

@RoutePage(name: 'GenreRoute')
class GenreScreen extends ConsumerStatefulWidget {
  const GenreScreen({super.key});

  @override
  ConsumerState<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends ConsumerState<GenreScreen> {
  final expandedNotifier = ValueNotifier<bool>(false);
  late MovieViewModel movieViewModel;
  List<GenreState> genreStates = [];
  List<Movie> currentMovieList = [];
  String lastSearch = '';
  Sorting selectedSort = Sorting.aToz;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  bool _prefsLoaded = false;

  Future<void> _loadPrefs() async {
    final search = await Prefs.getSearch();
    final sortName = await Prefs.getSort();
    setState(() {
      lastSearch = search;
      selectedSort = Sorting.values.firstWhere(
        (s) => s.name == sortName,
        orElse: () => Sorting.aToz,
      );
    });
    _prefsLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final movieViewModelAsync = ref.watch(movieViewModelProvider);
    return movieViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        movieViewModel = viewModel;
        buildGenreState();
        return buildScreen();
      },
    );
  }

  void buildGenreState() {
    genreStates.clear();
    for (final genre in movieViewModel.movieGenres!) {
      genreStates.add(GenreState(genre: genre, isSelected: false));
    }
  }

  Widget buildScreen() {
    final isDarkMode = ref.watch(themeProvider);
    return SafeArea(
      child: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16.0, 0.0, 24.0),
                          child: Text('Find a Movie',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        GenreSearchRow(
                          key: ValueKey(lastSearch),
                          (searchString) async {
                          await Prefs.saveSearch(searchString); // ✅ salva
                        }, initialValue: lastSearch), // ✅ restaura
                      ],
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                      valueListenable: expandedNotifier,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return GenreSection(
                          genreStates: genreStates,
                          isExpanded: value,
                          onGenresExpanded: (expanded) {
                            expandedNotifier.value = expanded;
                          },
                          onGenresSelected: (List<GenreState> states) {},
                        );
                      }),
                  const SliverDivider(),
                  SortPicker(
                    useSliver: true,
                    initialSort: selectedSort, // ✅ restaura
                    onSortSelected: (sorting) async {
                      setState(() => selectedSort = sorting);
                      await Prefs.saveSort(sorting.name); // ✅ salva
                    },
                  ),
                  VerticalMovieList(
                    movies: currentMovieList,
                    onMovieTap: (movieId) {
                      context.router.push(MovieDetailRoute(movieId: movieId));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}