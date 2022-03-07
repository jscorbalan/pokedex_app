import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../data/datasources/api_datasource.dart';
import '../../../data/repositories/pokemon_repository.dart';
import '../../../routes/routes.dart';
import '../blocs/pokemon_bloc/pokemon_bloc.dart';
import '../blocs/pokemon_list/pokemon_list_bloc.dart';

class PokemonListPage extends StatelessWidget {
  final ValueNotifier<bool> _showSearch = ValueNotifier<bool>(false);
  final ValueNotifier<String> _query = ValueNotifier<String>('');

  PokemonListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) =>
          PokemonListBloc(PokemonRepository(PokemonApiImpl()))..add(GetNextPokemons()),
      child: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder<bool>(
            builder: (context, showSearch, child) {
              return showSearch
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: TextField(
                        autofocus: true,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          _query.value = value;
                        },
                        decoration: const InputDecoration(
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    )
                  : const Text('PokeDex');
            },
            valueListenable: _showSearch,
          ),
          actions: [
            IconButton(
              onPressed: () {
                _query.value = '';
                _showSearch.value = !_showSearch.value;
              },
              icon: ValueListenableBuilder<bool>(
                  valueListenable: _showSearch,
                  builder: (context, showSearch, child) {
                    return Icon(showSearch ? Icons.close : Icons.search);
                  }),
            ),
          ],
        ),
        body: BlocBuilder<PokemonListBloc, PokemonListState>(
          builder: (context, state) {
            return ValueListenableBuilder<String>(
              valueListenable: _query,
              builder: (context, query, child) {
                final blocs = state.pokemonBlocs
                    .where(
                        (p) => query.isEmpty || p.state.pokemonResultFromList.name.contains(query))
                    .toList();
                return ListView.builder(
                  itemCount: blocs.length,
                  itemBuilder: (context, index) {
                    return BlocProvider.value(
                      value: blocs[index]..add(GetPokemonData()),
                      child: GestureDetector(
                        onTap: () {
                          if (blocs[index].state.pokemon != null) {
                            Navigator.of(context).pushNamed(
                              Routes.pokemonDetailRoute,
                              arguments: blocs[index].state.pokemon!,
                            );
                          }
                        },
                        child: Card(
                          child: BlocBuilder<PokemonBloc, PokemonState>(
                            builder: (context, state) {
                              return ListTile(
                                trailing: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: state.status == Status.success
                                        ? Hero(
                                            tag: state.pokemon!.id,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${state.pokemon!.id}.png',
                                              placeholder: (context, url) => Container(
                                                color: Colors.grey[100],
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  const Icon(Icons.image),
                                            ),
                                          )
                                        : Container(
                                            height: 26,
                                            width: 26,
                                            color: Colors.grey[100],
                                          ),
                                  ),
                                ),
                                title: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: state.status == Status.success
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.pokemon!.id.toString(),
                                            ),
                                            const Spacer(),
                                            Text(state.pokemon!.name),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            const Spacer(),
                                            Container(
                                              height: 26,
                                              width: 300,
                                              color: Colors.grey[100],
                                            ),
                                          ],
                                        ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
