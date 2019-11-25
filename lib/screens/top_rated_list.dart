import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/models/top_rated_model.dart';
import 'package:http/http.dart' as http;

import 'top_rated_detail.dart';

class TopRatedList extends StatefulWidget {
  @override
  _TopRatedListState createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  UpcomingModel topRatedData;

  final apikey = 'Your_api_key';
  final baseURL = 'https://api.themoviedb.org/3/movie';
  final imageURL = 'https://image.tmdb.org/t/p/';
  final size = 'w500';

  Future<UpcomingModel> fetchData() async {
    var respone = await http
        .get('$baseURL/top_rated?api_key=$apikey&language=en-US&page=1');
    if (respone.statusCode == 200) {
      var decordJson = jsonDecode(respone.body);
      topRatedData = UpcomingModel.fromJson(decordJson);
//      print(topRatedData.toJson());
      setState(() {});
    }
    return topRatedData;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.cyan,
//        title: Center(child: Text('Now Playing Movie')),
//      ),
      body: topRatedData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 1,
              children: topRatedData.results
                  .map((rated) => Padding(
                        padding: EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            print(rated.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopRatedDetail(
                                          results: rated,
                                          apikey: apikey,
                                          imageURL: imageURL,
                                          baseURL: baseURL,
                                          size: size,
                                          id: rated.id,
                                        )));
                          },
                          child: Hero(
                            tag:
                                '$imageURL$size${rated.posterPath}?api_key=$apikey',
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(
                                    flex: 12,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
//                                        fit: BoxFit.cover,
                                          image: NetworkImage(
                                            '$imageURL$size${rated.posterPath}?api_key=$apikey',
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
                                        'VoteAverage : ${rated.voteAverage.toString()}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
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
