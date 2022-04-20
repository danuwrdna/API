import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailModel {
  MovieDetailModel(
      {required this.title,
      required this.genre,
      required this.director,
      required this.actors,
      required this.plot,
      required this.poster});

  String title;
  String genre;
  String director;
  String actors;
  String plot;
  String poster;

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
          title: json["Title"],
          genre: json["Genre"],
          director: json["Director"],
          actors: json["Actors"],
          plot: json["Plot"],
          poster: json["Poster"]);

  static Future<MovieDetailModel> fetchdataFromAPI(String idMovie) async {
    Uri apiURL = Uri.http(
        "http://www.omdbapi.com", "", {"apikey": "3940860a", "i": idMovie});
    final apiResult = await http.get(apiURL);
    final jsonObject = json.decode(apiResult.body);
    return MovieDetailModel.fromJson(jsonObject);
  }
}
