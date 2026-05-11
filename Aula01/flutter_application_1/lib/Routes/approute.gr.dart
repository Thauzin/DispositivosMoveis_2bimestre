// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'approute.dart';

/// generated route for
/// [DetalhesPage]
class DetalhesRoute extends PageRouteInfo<DetalhesRouteArgs> {
  DetalhesRoute({
    Key? key,
    required FilmeItem filme,
    List<PageRouteInfo>? children,
  }) : super(
         DetalhesRoute.name,
         args: DetalhesRouteArgs(key: key, filme: filme),
         initialChildren: children,
       );

  static const String name = 'DetalhesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetalhesRouteArgs>();
      return DetalhesPage(key: args.key, filme: args.filme);
    },
  );
}

class DetalhesRouteArgs {
  const DetalhesRouteArgs({this.key, required this.filme});

  final Key? key;

  final FilmeItem filme;

  @override
  String toString() {
    return 'DetalhesRouteArgs{key: $key, filme: $filme}';
  }
}

/// generated route for
/// [FilmesListViewPage]
class FilmesListViewRoute extends PageRouteInfo<FilmesListViewRouteArgs> {
  FilmesListViewRoute({
    Key? key,
    required List<FilmeItem> filmes,
    List<PageRouteInfo>? children,
  }) : super(
         FilmesListViewRoute.name,
         args: FilmesListViewRouteArgs(key: key, filmes: filmes),
         initialChildren: children,
       );

  static const String name = 'FilmesListViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilmesListViewRouteArgs>();
      return FilmesListViewPage(key: args.key, filmes: args.filmes);
    },
  );
}

class FilmesListViewRouteArgs {
  const FilmesListViewRouteArgs({this.key, required this.filmes});

  final Key? key;

  final List<FilmeItem> filmes;

  @override
  String toString() {
    return 'FilmesListViewRouteArgs{key: $key, filmes: $filmes}';
  }
}
