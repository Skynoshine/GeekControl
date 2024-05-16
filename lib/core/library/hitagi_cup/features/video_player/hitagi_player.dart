import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HitagiPlayer extends StatefulWidget {
  const HitagiPlayer({super.key});

  @override
  State<HitagiPlayer> createState() => _HitagiPlayerState();
}

class _HitagiPlayerState extends State<HitagiPlayer> {
  late YoutubePlayerController _controller;
  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  bool isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'Gw_5xjurrbs',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(() {
        setState(() {
          playerState = _controller.value.playerState;
          videoMetaData = _controller.metadata;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          onReady: () {
            isPlayerReady = true;
          },
          onEnded: (metaData) {
            _controller
              ..load('dQw4w9WgXcQ')
              ..play();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
