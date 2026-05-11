import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'models/filme_item.dart';


@RoutePage()
class FilmesListViewPage extends StatelessWidget {
   FilmesListViewPage({super.key, required this.filmes});

  final List<FilmeItem> filmes;
  bool favorito = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: filmes.length,
      itemBuilder: (context,index){
        final filme = filmes[index];
    return GestureDetector(
  onTap: () {
    // Comando do AutoRoute para navegar passando o objeto filme
    context.router.push(DetalhesRoute(filme: filme));
  },
      
          return Center(
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(bottom: 16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 27 / 40,
                    child: Image.network(
                      filme.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) {
                            return Container(
                              color: const Color(0xFFB0BEC5),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.broken_image_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                            );
                          },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      filme.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Adicionado aos favoritos ❤️"),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          );
        );
      },
    );
  }
}