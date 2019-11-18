import 'package:flutter/material.dart';

import 'now_playing_model.dart';
import 'youtube_demo.dart';

class NowPlayingDetail extends StatelessWidget {
  final Results results;
  final String apikey;
  final String imageURL;
  final String size;

  NowPlayingDetail({
    this.results,
    this.apikey,
    this.imageURL,
    this.size,
  });

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
                      results.originalTitle,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    tooltip: 'trailer',
                    icon: Icon(
                      Icons.local_movies,
                      size: 40.0,
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => YoutubeDemo())),
                  ),
                  Text("GenreIds",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: results.genreIds == null
                        ? <Widget>[Text("This is the final form")]
                        : results.genreIds
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
                tag: '$imageURL$size${results.posterPath}?api_key=$apikey',
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 250.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
//                      fit: BoxFit.cover,
                        image: NetworkImage(
                            '$imageURL$size${results.posterPath}?api_key=$apikey'),
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
