import 'dart:convert';

import 'pokemon_result.dart';

class PokemoListResult {
    PokemoListResult({
        required this.count,
        this.next,
        this.previous,
        required this.results,
    });

    final int count;
    final String? next;
    final String? previous;
    final List<Pokemon> results;

    PokemoListResult copyWith({
        required int count,
        String? next,
        String? previous,
        required List<Pokemon> results,
    }) => 
        PokemoListResult(
            count: count,
            next: next,
            previous: previous,
            results: results,
        );

    factory PokemoListResult.fromRawJson(String str) => PokemoListResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PokemoListResult.fromJson(Map<String, dynamic> json) => PokemoListResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Pokemon>.from(json["results"].map((x) => Pokemon.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}
