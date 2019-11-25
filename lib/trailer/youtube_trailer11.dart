import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../screens/upcoming_detail.dart';

class YoutubeTrailer11 extends StatefulWidget {
  @override
  _YoutubeTrailer11State createState() => _YoutubeTrailer11State();
}

class _YoutubeTrailer11State extends State<YoutubeTrailer11> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: UpcomingDetail.videoId11,
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
