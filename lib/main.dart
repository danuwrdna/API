import 'package:flutter/material.dart';
import 'package:web_api/MovieList.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build( context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.teal[100],
        textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.deepOrange,
      ),
      home: const MovieList(),
    );
  }
}