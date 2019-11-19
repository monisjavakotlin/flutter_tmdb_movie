import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'now_playing_detail.dart';
import 'now_playing_model.dart';

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
  NowPlayingModel nowPlayingData;

  final apikey = 'Your_api_key';
  final baseURL = 'https://api.themoviedb.org/3/movie';
  final imageURL = 'https://image.tmdb.org/t/p/';
  final size = 'w500';

  Future<NowPlayingModel> fetchMovieList() async {
    var respone = await http.get('$baseURL/now_playing?api_key=$apikey');
    if (respone.statusCode == 200) {
      var decodedJson = jsonDecode(respone.body);
      nowPlayingData = NowPlayingModel.fromJson((decodedJson));
      print(nowPlayingData.toJson());
      setState(() {});
    } else {
      throw Exception('Failed to load data');
    }
    return nowPlayingData;
  }

  @override
  void initState() {
    super.initState();
    fetchMovieList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(child: Text('Now Playing Movie')),
      ),
      body: nowPlayingData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 1,
              children: nowPlayingData.results
                  .map((playing) => Padding(
                        padding: EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            print(playing.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NowPlayingDetail(
                                          results: playing,
                                          apikey: apikey,
                                          imageURL: imageURL,
                                          baseURL: baseURL,
                                          size: size,
                                          id: playing.id,
                                        )));
                          },
                          child: Hero(
                            tag:
                                '$imageURL$size${playing.posterPath}?api_key=$apikey',
                            child: Card(
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    flex: 12,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
//                                        fit: BoxFit.cover,
                                          image: NetworkImage(
                                            '$imageURL$size${playing.posterPath}?api_key=$apikey',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Text(
                                        'VoteAverage : ${playing.voteAverage.toString()}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  /* Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(
                                        'Popularity : ${v.popularity}',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
