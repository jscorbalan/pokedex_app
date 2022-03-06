import 'package:flutter/material.dart';
import 'package:pokedex_app/app/modules/pokemon_module/pages/pokemon_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (_) => const PokemonListPage(), 
      },
    );
  }
}