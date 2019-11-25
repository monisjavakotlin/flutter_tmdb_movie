import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../screens/popular_detail.dart';

class YoutubeTrailer7 extends StatefulWidget {
  @override
  _YoutubeTrailer7State createState() => _YoutubeTrailer7State();
}

class _YoutubeTrailer7State extends State<YoutubeTrailer7> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: PopularDetail.videoId7,
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
