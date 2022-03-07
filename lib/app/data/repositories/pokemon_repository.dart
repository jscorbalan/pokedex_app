import 'package:dartz/dartz.dart';

import '../../core/utils/constants.dart';
import '../datasources/api_datasource.dart';
import '../models/app_errors.dart';
import '../models/pokemon.dart';
import '../models/pokemon_result_from_list.dart';

class PokemonRepository {
  final PokemonApiImpl _api;

  int pokemonsCount = Constants.pokemonsCount;
  int quantityPerPage = Constants.quantityPerPage;
  int pageOffset = Constants.pageOffset;

  PokemonRepository(this._api);

  Future<Either<AppError, Pokemon>> getPokemonFromURL(String stringUrl) async {
    return await _api.getPokemonFromURL(stringUrl);
  }

  Future<Either<AppError, List<PokemonResultFromList>>> getNextPage() async {
    if (pageOffset > pokemonsCount) {
      return right([]);
    }

    final response = await _api.getPaginated(quantityPerPage, pageOffset);

    return response.map((result) {
      pokemonsCount = result.count;
      pageOffset += quantityPerPage;
      return result.results;
    });
  }
}
