import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/repositories/pokemon_repository.dart';
import '../pokemon_bloc/pokemon_bloc.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonRepository _repository;

  PokemonListBloc(this._repository) : super(PokemonListState.initial()) {
    on<GetNextPokemons>((event, emit) async {
      try {
        if (state.hasReachedMax) {
          return;
        }
        final response = await _repository.getNextPage();
        response.fold(
          (error) => emit(state.copyWith(status: Status.failure)),
          (pokemons) => pokemons.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(
                  state.copyWith(
                    status: Status.success,
                    pokemonBlocs: List.of(state.pokemonBlocs)
                      ..addAll(pokemons
                          .map((pokemonFromList) => PokemonBloc(_repository, pokemonFromList))
                          .toList()),
                  ),
                ),
        );
      } catch (_) {
        emit(state.copyWith(status: Status.failure));
      }
    });
  }
}
