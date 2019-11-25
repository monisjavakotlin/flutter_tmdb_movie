import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import './now_playing_detail.dart';
import '../models/now_playing_model.dart';

class Item {
  const Item(this.name);
  final String name;
}

class NowPlayingList extends StatefulWidget {
  String page = '1';
  Item selectedUser;
  List<Item> users = <Item>[
    Item('1'),
    Item('2'),
    Item('3'),
    Item('4'),
    Item('5'),
  ];

  @override
  _NowPlayingListState createState() => _NowPlayingListState();
}

class _NowPlayingListState extends State<NowPlayingList> {
  NowPlayingModel nowPlayingData;

  final apikey = 'Your_api_key';
  final baseURL = 'https://api.themoviedb.org/3/movie';
  final imageURL = 'https://image.tmdb.org/t/p/';
  final size = 'w500';

  Future<NowPlayingModel> fetchMovieList() async {
    var respone = await http.get(
        '$baseURL/now_playing?api_key=$apikey&language=en-US&page=${widget.page}');
    if (respone.statusCode == 200) {
      var decodedJson = jsonDecode(respone.body);
      nowPlayingData = NowPlayingModel.fromJson((decodedJson));
//      print(nowPlayingData.toJson());
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
        actions: <Widget>[
          DropdownButton(
//                  hint: Text('Select item'),
            hint: Text('Page'),
//            hint: Icon(Icons.more_vert),
            value: widget.selectedUser,
            onChanged: (Item Value) {
              setState(() {
                widget.selectedUser = Value;
                widget.page = widget.selectedUser.name;
                fetchMovieList();
              });
              print(widget.page);
            },
            items: widget.users.map((Item user) {
              return DropdownMenuItem<Item>(
                value: user,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'page:${user.name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
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
                                '$imageURL$size${playing.posterPath}?api_key=$apikey&language=en-US&page=${widget.page}',
                            child: Card(
                              elevation: 5.0,
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
                                            '$imageURL$size${playing.posterPath}?api_key=$apikey&language=en-US&page=${widget.page}',
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
