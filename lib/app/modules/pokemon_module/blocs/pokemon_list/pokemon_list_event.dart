part of 'pokemon_list_bloc.dart';

@immutable
abstract class PokemonListEvent {}

class GetNextPokemons implements PokemonListEvent {}

class GetPokemonInfoFromURL implements PokemonListEvent {
  final String stringUrl;

  GetPokemonInfoFromURL(this.stringUrl);
}
