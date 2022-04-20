import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Movie {
  Movie({
    required this.search,
  });
  List<MovieData>? search;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      search: (json["Response"] == "True")
          ? List<MovieData>.from(
              json["Search"].map((x) => MovieData?.fromJson(x)))
          : null);

  static Future<Movie> fetchdataFromAPI(String searchKey) async {
    Uri apiURL = Uri.http(
        "http://www.omdbapi.com", "", {"apikey": "3940860a", "s": searchKey});
    final apiResult = await http.get(apiURL);
    final jsonObject = json.decode(apiResult.body);
    return Movie.fromJson(jsonObject);
  }
}

class MovieData {
  MovieData({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.poster,
  });

  String title;
  String year;
  String imdbId;
  String poster;

  factory MovieData.fromJson(Map<String, dynamic> json) => MovieData(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        poster: json["Poster"],
      );
}
