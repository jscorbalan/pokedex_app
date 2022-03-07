import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/pokemon.dart';
import '../../../../data/models/pokemon_result_from_list.dart';
import '../../../../data/repositories/pokemon_repository.dart';
import '../pokemon_list/pokemon_list_bloc.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _repository;

  PokemonBloc(this._repository, PokemonResultFromList pokemonFromList)
      : super(PokemonState.initial(pokemonFromList)) {
    on<GetPokemonData>((event, emit) async {
      if (state.pokemon != null) {
        return;
      }

      final response = await _repository.getPokemonFromURL(state.pokemonResultFromList.url);

      response.fold((error) {
        emit(state.copyWith(status: Status.failure));
      }, (pokemon) {
        emit(state.copyWith(pokemon: pokemon, status: Status.success));
      });
    });
  }
}
