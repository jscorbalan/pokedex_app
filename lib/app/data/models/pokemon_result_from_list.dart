
import 'dart:convert';

class PokemonResultFromList {
  PokemonResultFromList({
        required this.name,
        required this.url,
    });

    final String name;
    final String url;

  PokemonResultFromList copyWith({
        required String name,
        required String url,
    }) => 
      PokemonResultFromList(
            name: name ,
            url: url,
        );

  factory PokemonResultFromList.fromRawJson(String str) =>
      PokemonResultFromList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

  factory PokemonResultFromList.fromJson(Map<String, dynamic> json) => PokemonResultFromList(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
