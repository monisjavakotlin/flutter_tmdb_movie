import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/screens/now_playing_detail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/now_playing_model.dart';

class YoutubeTrailer extends StatefulWidget {
  final Results results;

  YoutubeTrailer({this.results});

  @override
  _YoutubeTrailerState createState() => _YoutubeTrailerState();
}

class _YoutubeTrailerState extends State<YoutubeTrailer> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: NowPlayingDetail.videoId1,
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
      /*  appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Trailer'),
      ),*/
      body: OrientationBuilder(builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Column(
                children: <Widget>[
                  Container(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      liveUIColor: Colors.amber,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Title : ${widget.results.originalTitle}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Popularity : ${widget.results.popularity}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'VoteAverage : ${widget.results.voteAverage}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Adult : ${widget.results.adult}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ReleaseDate : ${widget.results.releaseDate}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
