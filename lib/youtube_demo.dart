import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDemo extends StatefulWidget {
  @override
  _YoutubeDemoState createState() => _YoutubeDemoState();
}

class _YoutubeDemoState extends State<YoutubeDemo> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'xRjvmVaFHkk',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        controller: _controller,
        liveUIColor: Colors.amber,
      ),
    );
  }
}
