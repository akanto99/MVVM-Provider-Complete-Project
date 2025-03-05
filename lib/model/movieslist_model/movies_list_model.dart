// To parse this JSON data, do
//
//     final moviesListModel = moviesListModelFromJson(jsonString);

import 'dart:convert';

MoviesListModel moviesListModelFromJson(String str) => MoviesListModel.fromJson(json.decode(str));

String moviesListModelToJson(MoviesListModel data) => json.encode(data.toJson());

class MoviesListModel {
  List<Movie>? movies;

  MoviesListModel({
    this.movies,
  });

  factory MoviesListModel.fromJson(Map<String, dynamic> json) => MoviesListModel(
    movies: json["movies"] == null ? [] : List<Movie>.from(json["movies"]!.map((x) => Movie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "movies": movies == null ? [] : List<dynamic>.from(movies!.map((x) => x.toJson())),
  };
}

class Movie {
  String? id;
  String? title;
  String? year;
  List<String>? genres;
  List<int>? ratings;
  String? poster;
  dynamic? contentRating;
  String? duration;
  String? releaseDate;
  dynamic? averageRating;
  OriginalTitle? originalTitle;
  String? storyline;
  List<String>? actors;
  dynamic imdbRating;
  String? posterurl;

  Movie({
    this.id,
    this.title,
    this.year,
    this.genres,
    this.ratings,
    this.poster,
    this.contentRating,
    this.duration,
    this.releaseDate,
    this.averageRating,
    this.originalTitle,
    this.storyline,
    this.actors,
    this.imdbRating,
    this.posterurl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    title: json["title"],
    year: json["year"],
    genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
    ratings: json["ratings"] == null ? [] : List<int>.from(json["ratings"]!.map((x) => x)),
    poster: json["poster"],
    contentRating: json["contentRating"],
    duration: json["duration"],
    releaseDate: json["releaseDate"],
    averageRating: json["averageRating"],
    originalTitle: originalTitleValues.map[json["originalTitle"]]!,
    storyline: json["storyline"],
    actors: json["actors"] == null ? [] : List<String>.from(json["actors"]!.map((x) => x)),
    imdbRating: json["imdbRating"],
    posterurl: json["posterurl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "year": year,
    "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
    "ratings": ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x)),
    "poster": poster,
    "contentRating": contentRating,
    "duration": duration,
    "releaseDate": releaseDate,
    "averageRating": averageRating,
    "originalTitle": originalTitleValues.reverse[originalTitle],
    "storyline": storyline,
    "actors": actors == null ? [] : List<dynamic>.from(actors!.map((x) => x)),
    "imdbRating": imdbRating,
    "posterurl": posterurl,
  };
}

enum OriginalTitle {
  ANNIHILATION,
  A_WRINKLE_IN_TIME,
  CE_QUI_NOUS_LIE,
  EMPTY,
  THE_LEISURE_SEEKER
}

final originalTitleValues = EnumValues({
  "Annihilation": OriginalTitle.ANNIHILATION,
  "A Wrinkle in Time": OriginalTitle.A_WRINKLE_IN_TIME,
  "Ce qui nous lie": OriginalTitle.CE_QUI_NOUS_LIE,
  "": OriginalTitle.EMPTY,
  "The Leisure Seeker": OriginalTitle.THE_LEISURE_SEEKER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
