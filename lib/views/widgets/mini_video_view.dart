import 'dart:typed_data';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class MiniVideoView extends StatefulWidget {
  const MiniVideoView({Key? key, required this.bytes}) : super(key: key);
  final Uint8List? bytes;

  @override
  State<MiniVideoView> createState() => _MiniVideoViewState();
}

class _MiniVideoViewState extends State<MiniVideoView> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  String videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    createNetUrlFromBytes();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((value) => setState(() {}))
      ..play()
      ..setVolume(0);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
      customVideoPlayerSettings: const CustomVideoPlayerSettings(
        showFullscreenButton: false,
        settingsButtonAvailable: false,
      ),
    );

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position >= videoPlayerController.value.duration) {
        videoPlayerController.play();
      }
    });
  }

  void createNetUrlFromBytes() {
    final blob = html.Blob([widget.bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    debugPrint("createNetUrlFromBytes: $url");
    videoUrl = url;
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 180,
        width: 180,
        color: Colors.white,
        child: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController,
        ),
      ),
    );
  }
}
