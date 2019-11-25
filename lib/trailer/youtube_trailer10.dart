import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/screens/upcoming_detail.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../screens/upcoming_detail.dart';

class YoutubeTrailer10 extends StatefulWidget {
  @override
  _YoutubeTrailer10State createState() => _YoutubeTrailer10State();
}

class _YoutubeTrailer10State extends State<YoutubeTrailer10> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: UpcomingDetail.videoId10,
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
