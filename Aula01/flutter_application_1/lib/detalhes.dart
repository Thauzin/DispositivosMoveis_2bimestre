import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../models/filme_item.dart';

@RoutePage()
class DetalhesPage extends StatelessWidget {
  // Passamos o filme via construtor para exibir os dados
  final FilmeItem filme;

  const DetalhesPage({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filme.titulo),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem de destaque (Poster)
            Hero(
              tag: filme.imageUrl,
              child: Image.network(
                filme.imageUrl,
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filme.titulo,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 5),
                      Text("4.8 (Crítica)", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Sinopse",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Aqui vai a descrição do filme. Como o seu modelo FilmeItem "
                    "atualmente foca no título e imagem, você pode expandir o model "
                    "no futuro para incluir uma string de descrição!",
                    style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
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