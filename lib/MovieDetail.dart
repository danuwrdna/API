import 'package:flutter/material.dart';
import 'package:web_api/models/MovieDetailModel.dart';

class MovieDetail extends StatefulWidget {
  final movieId;
  const MovieDetail({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailModel? movieInfo;
  @override
  void initState(){
    MovieDetailModel.fetchdataFromAPI(this.widget.movieId).then((value){
      movieInfo = value;
      setState(() {});
    });
      super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Movie Description"),
        centerTitle: true,
      ),
      body: (movieInfo == null)
      ? Center(
        child: CircularProgressIndicator(),
      )
      : ListView(
        children: [
       Stack(
         children: <Widget>[
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(movieInfo!.poster),
              fit: BoxFit.fill)),
               ),
               Container(
                 height: 300,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   gradient:LinearGradient(
                     begin: Alignment(0, 1),
                     end: Alignment(0,0.06),
                     colors: [
                       Colors.white,
                       Colors.white.withOpacity(0)
                     ])),
                   )
         ],
               ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text(
                       "Title:",
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text(movieInfo!.title),
                     Text(
                       'Genre:',
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text(movieInfo!.genre),
                     Text(
                       'Director:',
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text(movieInfo!.director),
                     Text(
                       'Actors:',
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text(movieInfo!.actors),
                     Text(
                       'Plot:',
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text(movieInfo!.plot),
                 
                   ],
                 ),
                 ),
        ],
        ),
    );
       
    
    
  }
}
