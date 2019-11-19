import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/now_playing_detail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeTrailer extends StatelessWidget {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: NowPlayingDetail.videoId,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Trailer'),
      ),
      body: Center(
        child: Container(
          child: YoutubePlayer(
            controller: _controller,
            liveUIColor: Colors.amber,
          ),
        ),
      ),
    );
  }
}
