import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerURL extends StatefulWidget {
  String url;
  String name;
  bool appBar;
  VideoPlayerURL({required this.url, required this.name, required this.appBar});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerURL> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
            // width: double.infinity,
            // height: 250,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )),
      ),
    );
  }
}
