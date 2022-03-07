import 'dart:convert';

import 'pokemon_result_from_list.dart';

class PokemonListResult {
  PokemonListResult({
        required this.count,
        this.next,
        this.previous,
        required this.results,
    });

    final int count;
    final String? next;
    final String? previous;
  final List<PokemonResultFromList> results;

  PokemonListResult copyWith({
        required int count,
        String? next,
        String? previous,
    required List<PokemonResultFromList> results,
    }) => 
      PokemonListResult(
            count: count,
            next: next,
            previous: previous,
            results: results,
        );

  factory PokemonListResult.fromRawJson(String str) => PokemonListResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

  factory PokemonListResult.fromJson(Map<String, dynamic> json) => PokemonListResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PokemonResultFromList>.from(
            json["results"].map((x) => PokemonResultFromList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}
