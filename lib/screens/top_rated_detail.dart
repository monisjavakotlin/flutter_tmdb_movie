import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/posters/top_poster_show.dart';
import 'package:http/http.dart' as http;

import '../models/query_key_model.dart';
import '../models/top_rated_model.dart';
import '../trailer/youtube_trailer4.dart';
import '../trailer/youtube_trailer5.dart';
import '../trailer/youtube_trailer6.dart';

class TopRatedDetail extends StatefulWidget {
  final List<String> keys = List<String>();
  static String videoId4 = '';
  static String videoId5 = '';
  static String videoId6 = '';

  final Results results;
  final String apikey;
  final String imageURL;
  final String baseURL;
  final String size;
  final int id;

  TopRatedDetail({
    this.results,
    this.apikey,
    this.imageURL,
    this.baseURL,
    this.size,
    this.id,
  });

  @override
  _TopRatedDetailState createState() => _TopRatedDetailState();
}

class _TopRatedDetailState extends State<TopRatedDetail> {
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
        TopRatedDetail.videoId4 = widget.keys[0];
        TopRatedDetail.videoId5 = widget.keys[1];
        TopRatedDetail.videoId6 = widget.keys[2];
        print(widget.keys[0]);
        print(widget.keys[1]);
        print(widget.keys[2]);
      } else if (widget.keys.length >= 2) {
        TopRatedDetail.videoId4 = widget.keys[0];
        TopRatedDetail.videoId5 = widget.keys[1];
        TopRatedDetail.videoId6 = '';
        print(widget.keys[0]);
        print(widget.keys[1]);
      } else {
        TopRatedDetail.videoId4 = widget.keys[0];
        TopRatedDetail.videoId5 = '';
        TopRatedDetail.videoId6 = '';
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
        title: Text('Top Rated Movie Detail'),
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
                                  builder: (context) => YoutubeTrailer4(
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
                                  builder: (context) => YoutubeTrailer5(
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
                                  builder: (context) => YoutubeTrailer6(
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
                              builder: (context) => PosterShow(
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
