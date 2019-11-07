import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'now_playing.dart';

void main() => runApp(App());
NowPlaying nowPlaying;

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
  final apikey = 'Your_apikey';
  final baseURL = 'https://api.themoviedb.org/3/movie';

  Future<NowPlaying> fetchMovieList() async {
    var respone = await http.get('$baseURL/now_playing?api_key=$apikey');
    if (respone.statusCode == 200) {
      var decodedJson = jsonDecode(respone.body);
      nowPlaying = NowPlaying.fromJson((decodedJson));
      print(nowPlaying.toJson());
      setState(() {});
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
        title: Text('Now Playing Movie'),
      ),
      body: nowPlaying == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: nowPlaying.results
                  .map((v) => Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              /*Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
//                                        '$baseURL/${v.backdropPath}'),
                                      'https://api.themoviedb.org/3/movie/w185${v.posterPath}',
                                    ),
                                  ),
                                ),
                              ),*/
                              Text(
                                v.originalTitle,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                '${v.popularity}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
