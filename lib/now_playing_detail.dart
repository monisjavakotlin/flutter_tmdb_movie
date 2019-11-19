import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'now_playing_model.dart';
import 'query_key_model.dart';
import 'youtube_demo.dart';

class NowPlayingDetail extends StatefulWidget {
  static String videoId = 'xRjvmVaFHkk';
  final Results results;
  final String apikey;
  final String imageURL;
  final String baseURL;
  final String size;
  final int id;

  NowPlayingDetail({
    this.results,
    this.apikey,
    this.imageURL,
    this.baseURL,
    this.size,
    this.id,
  });

  @override
  _NowPlayingDetailState createState() => _NowPlayingDetailState();
}

class _NowPlayingDetailState extends State<NowPlayingDetail> {
  QueryKey queryKeyData;

  Future<QueryKey> fetchVideoId(int id) async {
    var respone =
        await http.get('${widget.baseURL}/$id/videos?api_key=${widget.apikey}');
    if (respone.statusCode == 200) {
      var decodedJson = jsonDecode(respone.body);
      queryKeyData = QueryKey.fromJson((decodedJson));
      print(queryKeyData.toJson());
    } else {
      throw Exception('Failed to load data');
    }
    return queryKeyData;
  }

  @override
  void initState() {
    super.initState();
    fetchVideoId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blueGrey,
        title: Text('Now Playing Movie Detail'),
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
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  /*     IconButton(
                    tooltip: 'trailer',
                    icon: Icon(
                      Icons.reply_all,
                      size: 40.0,
                    ),
                    onPressed: () {
                      fetchVideoId(widget.id);
                    },
                  ),*/
                  IconButton(
                    tooltip: 'trailer',
                    icon: Icon(
                      Icons.local_movies,
                      size: 40.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YoutubeDemo()));
                    },
                  ),
                  Text("GenreIds",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.results.genreIds == null
                        ? <Widget>[Text("This is the final form")]
                        : widget.results.genreIds
                            .map((n) => FilterChip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    n.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {},
                                ))
                            .toList(),
                  )
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
                )),
          )
        ],
      ),
    );
  }
}
