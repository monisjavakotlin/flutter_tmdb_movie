import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'now_playing.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieList(),
    );
  }
}

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  NowPlaying nowPlaying;
  final apikey = 'Your_apikey';
  final baseURL = 'https://api.themoviedb.org/3/movie';

  Future<NowPlaying> fetchMovieList() async {
    var respone = await http.get('$baseURL/now_playing?api_key=$apikey');
    if (respone.statusCode == 200) {
      var decodedJson = jsonDecode(respone.body);
      nowPlaying = NowPlaying.fromJson((decodedJson));
      print(nowPlaying.toJson());
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MOVIE'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
//        children: nowPlaying.results.map((nowPlaying) => Card()).toList(),
      ),
    );
  }
}
