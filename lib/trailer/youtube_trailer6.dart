import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../screens/top_rated_detail.dart';

class YoutubeTrailer6 extends StatefulWidget {
  @override
  _YoutubeTrailer6State createState() => _YoutubeTrailer6State();
}

class _YoutubeTrailer6State extends State<YoutubeTrailer6> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: TopRatedDetail.videoId6,
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
