import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/popular_model.dart';
import '../models/query_key_model.dart';
import '../posters/popular_poster_show.dart';
import '../trailer/youtube_trailer7.dart';
import '../trailer/youtube_trailer8.dart';
import '../trailer/youtube_trailer9.dart';

class PopularDetail extends StatefulWidget {
  final List<String> keys = List<String>();
  static String videoId7 = '';
  static String videoId8 = '';
  static String videoId9 = '';

  final Results results;
  final String apikey;
  final String imageURL;
  final String baseURL;
  final String size;
  final int id;

  PopularDetail({
    this.results,
    this.apikey,
    this.imageURL,
    this.baseURL,
    this.size,
    this.id,
  });

  @override
  _PopularDetailState createState() => _PopularDetailState();
}

class _PopularDetailState extends State<PopularDetail> {
  QueryKeyModel queryKeyData;

  Future<QueryKeyModel> fetchVideoId(int id) async {
    var respone = await http.get(
        '${widget.baseURL}/$id/videos?api_key=${widget.apikey}&language=en-US&page=1');
    if (respone.statusCode == 200) {
      var decodedJson = jsonDecode(respone.body);
      queryKeyData = QueryKeyModel.fromJson((decodedJson));
//      print(queryKeyData.toJson());
      queryKeyData.results.forEach((f) => widget.keys.add(f.key));
      if (widget.keys.length >= 3) {
        PopularDetail.videoId7 = widget.keys[0];
        PopularDetail.videoId8 = widget.keys[1];
        PopularDetail.videoId9 = widget.keys[2];
        print(widget.keys[0]);
        print(widget.keys[1]);
        print(widget.keys[2]);
      } else if (widget.keys.length >= 2) {
        PopularDetail.videoId7 = widget.keys[0];
        PopularDetail.videoId8 = widget.keys[1];
        PopularDetail.videoId9 = '';
        print(widget.keys[0]);
        print(widget.keys[1]);
      } else {
        PopularDetail.videoId7 = widget.keys[0];
        PopularDetail.videoId8 = '';
        PopularDetail.videoId9 = '';
        print(widget.keys[0]);
      }
    } else {
      throw Exception('Failed to load data');
    }
    return queryKeyData;
  }

  @override
  void initState() {
    super.initState();
    fetchVideoId(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blueGrey,
        title: Text('Popular Movie Detail'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.15,
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 120.0,
                  ),
                  Center(
                    child: Text(
                      widget.results.originalTitle,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        tooltip: 'trailer1',
                        icon: Icon(
                          Icons.local_movies,
                          size: 40.0,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YoutubeTrailer7(
                                        results: widget.results,
                                      )));
                        },
                      ),
                      IconButton(
                        tooltip: 'trailer2',
                        icon: Icon(
                          Icons.local_movies,
                          size: 40.0,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YoutubeTrailer8(
                                        results: widget.results,
                                      )));
                        },
                      ),
                      IconButton(
                        tooltip: 'trailer3',
                        icon: Icon(
                          Icons.local_movies,
                          size: 40.0,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YoutubeTrailer9(
                                        results: widget.results,
                                      )));
                        },
                      ),
                    ],
                  ),
                  Text(
                    widget.results.overview,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag:
                    '${widget.imageURL}${widget.size}${widget.results.posterPath}?api_key=${widget.apikey}',
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PopularPosterShow(
                                    results: widget.results,
                                    apikey: widget.apikey,
                                    imageURL: widget.imageURL,
                                    baseURL: widget.baseURL,
                                    size: widget.size,
                                  )));
                    },
                    child: Container(
                      height: 250.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
//                      fit: BoxFit.cover,
                          image: NetworkImage(
                              '${widget.imageURL}${widget.size}${widget.results.posterPath}?api_key=${widget.apikey}'),
                        ),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
