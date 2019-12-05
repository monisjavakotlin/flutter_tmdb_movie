import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/popular_model.dart';
import '../screens/popular_detail.dart';

class YoutubeTrailer8 extends StatefulWidget {
  final Results results;

  YoutubeTrailer8({this.results});

  @override
  _YoutubeTrailer8State createState() => _YoutubeTrailer8State();
}

class _YoutubeTrailer8State extends State<YoutubeTrailer8> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: PopularDetail.videoId8,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: OrientationBuilder(builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 0.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '${widget.results.originalTitle}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      liveUIColor: Colors.amber,
                    ),
                  ),
//                  SizedBox(
//                    height: 30.0,
//                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Popularity : ${widget.results.popularity}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'VoteAverage : ${widget.results.voteAverage}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Adult : ${widget.results.adult}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ReleaseDate : ${widget.results.releaseDate}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            : Container(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  liveUIColor: Colors.amber,
                ),
              );
      }),
    );
  }
}
