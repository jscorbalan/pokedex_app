import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../data/models/pokemon.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                Text(
                  pokemon.name.replaceRange(0, 1, pokemon.name[0].toUpperCase()),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                ...pokemon.stats.map(
                  (e) => ListTile(
                    title: Text(e.stat.name),
                    trailing: Text(e.baseStat.toString()),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            color: Colors.blue,
          ),
          Align(
            alignment: const Alignment(0.0, -0.5),
            child: Hero(
              tag: pokemon.id,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.white,
                child: SizedBox(
                  height: 160,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png',
                    placeholder: (context, url) => Container(
                      color: Colors.grey[100],
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.image),
                  ),
                ),
              ),
            ),
          ),
          const SafeArea(
            child: BackButton(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
