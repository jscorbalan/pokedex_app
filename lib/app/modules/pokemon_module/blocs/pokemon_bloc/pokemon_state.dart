part of 'pokemon_bloc.dart';

class PokemonState {
  final Status status;
  final Pokemon? pokemon;
  final PokemonResultFromList pokemonResultFromList;

  factory PokemonState.initial(PokemonResultFromList pokemonFromList) =>
      PokemonState(Status.initial, null, pokemonFromList);

  PokemonState(this.status, this.pokemon, this.pokemonResultFromList);

  PokemonState copyWith({
    Status? status,
    Pokemon? pokemon,
    PokemonResultFromList? pokemonResultFromList,
  }) {
    return PokemonState(
      status ?? this.status,
      pokemon ?? this.pokemon,
      pokemonResultFromList ?? this.pokemonResultFromList,
    );
  }
}
