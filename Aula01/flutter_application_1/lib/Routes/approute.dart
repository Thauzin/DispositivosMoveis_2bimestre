import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../models/filme_item.dart';
import '../models/tema_item.dart';
import '../widgets/temas_gridviewPage.dart';

import '../filmes_listviewPage.dart';
import '../detalhes.dart';

part 'approute.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [

        AutoRoute(
          page: FilmesListViewRoute.page,
          initial: true,
        ),

        AutoRoute(
          page: DetalhesRoute.page,
        ),
      ];
}