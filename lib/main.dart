import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final apikey = 'Your api_key';
  final baseURL = 'https://api.themoviedb.org/3/movie';
  final imageURL = 'https://image.tmdb.org/t/p/';
  final size = 'w500';

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
              crossAxisCount: 1,
              children: nowPlaying.results
                  .map((v) => Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          child: Card(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                /*Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    v.originalTitle,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),*/
                                Flexible(
                                  flex: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
//                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          '$imageURL$size${v.posterPath}?api_key=$apikey',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      'VoteAverage : ${v.voteAverage.toString()}',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      'Popularity : ${v.popularity}',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
