import 'dart:io';

import 'package:dartz/dartz.dart';

import '../models/app_error.dart';

abstract class ApiDataSource {
  Future<Either<AppError, List>> getAll();
  Future<Either<AppError, List>> getPaginated(int limit, int offset);
}

class PokemonApi implements ApiDataSource {
  late HttpClient _client;

  PokemonApi() {
    _client = HttpClient();
  }

  // PokemonApi{
  //   _client = HttpClient();
  // }

  @override
  Future<Either<AppError, List>> getAll() {
    
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, List>> getPaginated(int limit, int offset) {
    // TODO: implement getPaginated
    throw UnimplementedError();
  }
}
