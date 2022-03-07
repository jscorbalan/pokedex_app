import 'dart:convert';

class Pokemon {
  Pokemon({
    required this.id,
    required this.name,
    required this.stats,
  });

  final int id;
  final String name;
  final List<StatElement> stats;

  Pokemon copyWith({
    required int id,
    required String name,
    required List<StatElement> stats,
  }) =>
      Pokemon(
        id: id,
        name: name,
        stats: stats,
      );

  factory Pokemon.fromRawJson(String str) => Pokemon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        name: json["name"],
        stats: List<StatElement>.from(json["stats"].map((x) => StatElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
      };
}

class StatElement {
  StatElement({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  final int baseStat;
  final int effort;
  final Stat stat;

  StatElement copyWith({
    required int baseStat,
    required int effort,
    required Stat stat,
  }) =>
      StatElement(
        baseStat: baseStat,
        effort: effort,
        stat: stat,
      );

  factory StatElement.fromRawJson(String str) => StatElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatElement.fromJson(Map<String, dynamic> json) => StatElement(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Stat.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}

class Stat {
  Stat({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  Stat copyWith({
    required String name,
    required String url,
  }) =>
      Stat(
        name: name,
        url: url,
      );

  factory Stat.fromRawJson(String str) => Stat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
