import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:movies/utils/prefs.dart';
import 'package:movies/network/movie_api_service.dart';
import 'package:movies/router/app_routes.dart';
import 'package:movies/ui/movie_viewmodel.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
MovieAPIService movieAPIService(MovieAPIServiceRef ref) => MovieAPIService();

@Riverpod(keepAlive: true)
Future<MovieViewModel> movieViewModel(MovieViewModelRef ref) async {
  final model = MovieViewModel(movieAPIService: ref.read(movieAPIServiceProvider));
  await model.setup();
  return model;
}


final heroTagProvider = StateProvider<String>((ref) {
  return '';
});

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(true) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final saved = await Prefs.getTheme();
    state = saved;
  }

  Future<void> toggle() async {
    state = !state;
    await Prefs.saveTheme(state);
  }
}


@Riverpod(keepAlive: true)
AppRouter appRouter(AppRouterRef ref) => AppRouter();

