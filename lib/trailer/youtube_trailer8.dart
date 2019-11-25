import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../screens/popular_detail.dart';

class YoutubeTrailer8 extends StatefulWidget {
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
