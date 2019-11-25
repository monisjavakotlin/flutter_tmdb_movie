import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/models/top_rated_model.dart';
import 'package:http/http.dart' as http;

import 'top_rated_detail.dart';

class PopularList extends StatefulWidget {
  @override
  _PopularListState createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {
  UpcomingModel popularData;

  final apikey = 'Your_api_key';
  final baseURL = 'https://api.themoviedb.org/3/movie';
  final imageURL = 'https://image.tmdb.org/t/p/';
  final size = 'w500';

  Future<UpcomingModel> fetchData() async {
    var respone = await http
        .get('$baseURL/popular?api_key=$apikey&language=en-US&page=1');
    if (respone.statusCode == 200) {
      var decordJson = jsonDecode(respone.body);
      popularData = UpcomingModel.fromJson(decordJson);
//      print(popularData.toJson());
      setState(() {});
    }
    return popularData;
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
      body: popularData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 1,
              children: popularData.results
                  .map((popu) => Padding(
                        padding: EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            print(popu.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopRatedDetail(
                                          results: popu,
                                          apikey: apikey,
                                          imageURL: imageURL,
                                          baseURL: baseURL,
                                          size: size,
                                          id: popu.id,
                                        )));
                          },
                          child: Hero(
                            tag:
                                '$imageURL$size${popu.posterPath}?api_key=$apikey',
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
                                            '$imageURL$size${popu.posterPath}?api_key=$apikey',
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
                                        'VoteAverage : ${popu.voteAverage.toString()}',
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
