import 'package:flutter/material.dart';
import 'package:geekcontrol/utils/default_image_test.dart';

class AnimeDetailsPage extends StatelessWidget {
  const AnimeDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Card.filled(
              elevation: 5,
              shadowColor: Colors.green,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  DefaultImage.banner,
                  height: 230,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Bakemonogatari',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 60,
            left: 20,
            child: Text(
              'Autor - Nishio Ishin',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 90,
            left: 20,
            child: Text(
              'Gêneros - Ação - Aventura - Fantasia',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 190,
            left: 20,
            child: Text(
              'Data de lançamento - 22/03/2012',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
