import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/screens/now_playing_detail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeTrailer3 extends StatefulWidget {
  @override
  _YoutubeTrailer3State createState() => _YoutubeTrailer3State();
}

class _YoutubeTrailer3State extends State<YoutubeTrailer3> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: NowPlayingDetail.videoId3,
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
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Trailer'),
      ),
      body: Center(
        child: Container(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            liveUIColor: Colors.amber,
          ),
        ),
      ),
    );
  }
}
