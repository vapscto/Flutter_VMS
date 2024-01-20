import 'package:flutter/material.dart';

import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;
  const VideoScreen({super.key, required this.videoUrl});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? controller;

  @override
  void initState() {
    controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Video").getAppBar(),
      body: Center(
        child: controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: VideoPlayer(controller!))
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (controller!.value.isPlaying) {
            controller!.pause();
            setState(() {});
            return;
          }
          controller!.play();
          setState(() {});
        },
        child: controller!.value.isPlaying
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
    );
  }
}
