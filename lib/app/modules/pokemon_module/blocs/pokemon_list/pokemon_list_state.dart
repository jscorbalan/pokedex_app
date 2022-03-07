part of 'pokemon_list_bloc.dart';

class PokemonListState {
  final Status status;
  final List<PokemonBloc> pokemonBlocs;
  final bool hasReachedMax;

  PokemonListState(this.status, this.pokemonBlocs, this.hasReachedMax);

  factory PokemonListState.initial() =>
      PokemonListState(Status.initial, const <PokemonBloc>[], false);

  PokemonListState copyWith({
    Status? status,
    List<PokemonBloc>? pokemonBlocs,
    bool? hasReachedMax,
  }) {
    return PokemonListState(
      status ?? this.status,
      pokemonBlocs ?? this.pokemonBlocs,
      hasReachedMax ?? this.hasReachedMax,
    );
  }
}

enum Status { initial, success, failure }
