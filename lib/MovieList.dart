import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_api/MovieDetail.dart';
import 'package:web_api/models/MovieModel.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  Movie? movieHead;
  List<MovieData>? movieList;

  @override
  void initState() {
    loadDataMovies("avenger");
    super.initState();
  }

  void loadDataMovies(String _keyword) {
    Movie.fetchdataFromAPI(_keyword).then((value) {
      movieHead = value;
      movieList = movieHead!.search;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearchMovie = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
        centerTitle: true,
      ),
      body: (movieHead == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (movieList == null || movieList!.length == 0)
              ? Center(
                  child: Text('No data Movies...'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Card(
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: txtSearchMovie,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Search Movies ...",
                              ),
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                loadDataMovies(txtSearchMovie.text);
                              },
                              icon: Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.teal,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: movieList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MovieCards(
                            poster: movieList![index].poster,
                            year: movieList![index].year,
                            title: movieList![index].title,
                            idOmDB: movieList![index].imdbId,
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

class MovieCards extends StatelessWidget {
  final poster;
  final year;
  final title;
  final idOmDB;
  const MovieCards({Key? key, this.poster, this.year, this.title, this.idOmDB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetail(movieId: idOmDB),
          ),
        );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
              child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(this.poster),
                        fit: BoxFit.fill,
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Year:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(this.year),
                  Text(
                    'Title:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(this.title),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
