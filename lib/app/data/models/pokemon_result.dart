
import 'dart:convert';

class Pokemon {
    Pokemon({
        required this.name,
        required this.url,
    });

    final String name;
    final String url;

    Pokemon copyWith({
        required String name,
        required String url,
    }) => 
        Pokemon(
            name: name ,
            url: url,
        );

    factory Pokemon.fromRawJson(String str) => Pokemon.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
