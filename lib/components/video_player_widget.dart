import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerHelper extends StatefulWidget {
  final String videoPath;

  const VideoPlayerHelper({Key? key, required this.videoPath})
      : super(key: key);

  @override
  _VideoPlayerHelperState createState() => _VideoPlayerHelperState();
}

class _VideoPlayerHelperState extends State<VideoPlayerHelper> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void didUpdateWidget(covariant VideoPlayerHelper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      _disposeVideoPlayer();
      _initializeVideoPlayer();
    }
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      showControlsOnInitialize: false,
      allowMuting: false,
      autoInitialize: true,
    );
  }

  void _disposeVideoPlayer() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }
}
