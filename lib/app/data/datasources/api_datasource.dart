import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';

import '../models/app_errors.dart';
import '../models/pokemon.dart';
import '../models/pokemon_list_result.dart';

abstract class PokemonApiDataSource {
  Future<Either<AppError, PokemonListResult>> getPaginated(int limit, int offset);
  Future<Either<AppError, Pokemon>> getPokemonFromURL(String url);
}

class PokemonApiImpl implements PokemonApiDataSource {

  @override
  Future<Either<AppError, PokemonListResult>> getPaginated(int limit, int offset) async {
    try {
      var url = Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return right(PokemonListResult.fromRawJson(response.body));
      }
      return left(ServerError());
    } catch (e) {
      return left(AppCrashError());
    }
  }

  @override
  Future<Either<AppError, Pokemon>> getPokemonFromURL(String stringUrl) async {
    try {
      var url = Uri.parse(stringUrl);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return right(Pokemon.fromRawJson(response.body));
      }
      return left(ServerError());
    } catch (e) {
      return left(AppCrashError());
    }
  }
}
