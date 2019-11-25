import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/upcoming_model.dart';
import '../screens/upcoming_detail.dart';

class UpcomingList extends StatefulWidget {
  @override
  _UpcomingListState createState() => _UpcomingListState();
}

class _UpcomingListState extends State<UpcomingList> {
  UpcomingModel upcomingData;

  final apikey = 'Your_api_key';
  final baseURL = 'https://api.themoviedb.org/3/movie';
  final imageURL = 'https://image.tmdb.org/t/p/';
  final size = 'w500';

  Future<UpcomingModel> fetchData() async {
    var respone = await http
        .get('$baseURL/upcoming?api_key=$apikey&language=en-US&page=1');
    if (respone.statusCode == 200) {
      var decordJson = jsonDecode(respone.body);
      upcomingData = UpcomingModel.fromJson(decordJson);
//      print(upcomingData.toJson());
      setState(() {});
    }
    return upcomingData;
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
      body: upcomingData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 1,
              children: upcomingData.results
                  .map((upcoming) => Padding(
                        padding: EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            print(upcoming.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpcomingDetail(
                                          results: upcoming,
                                          apikey: apikey,
                                          imageURL: imageURL,
                                          baseURL: baseURL,
                                          size: size,
                                          id: upcoming.id,
                                        )));
                          },
                          child: Hero(
                            tag:
                                '$imageURL$size${upcoming.posterPath}?api_key=$apikey',
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
                                            '$imageURL$size${upcoming.posterPath}?api_key=$apikey',
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
                                        'VoteAverage : ${upcoming.voteAverage.toString()}',
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
