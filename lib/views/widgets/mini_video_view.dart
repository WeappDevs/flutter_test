import 'dart:typed_data';
import 'package:admin_web_app/views/widgets/empty_view.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class MiniVideoView extends StatefulWidget {
  const MiniVideoView({Key? key, this.bytes, this.netImageURL, this.isNotMute}) : super(key: key);
  final Uint8List? bytes;
  final String? netImageURL;
  final bool? isNotMute;

  @override
  State<MiniVideoView> createState() => _MiniVideoViewState();
}

class _MiniVideoViewState extends State<MiniVideoView> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  String videoUrl = '';

  @override
  void initState() {
    super.initState();
    initVideoUrlActivity();
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) => setState(() {}))
      ..setVolume((widget.isNotMute == true) ? 1 : 0)
      ..play();
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

  void initVideoUrlActivity() {
    if (widget.bytes?.isNotEmpty == true) {
      createNetUrlFromBytes();
    } else {
      if (widget.netImageURL?.isNotEmpty == true) {
        videoUrl = widget.netImageURL!;
      }
    }
  }

  void createNetUrlFromBytes() {
    final blob = html.Blob([widget.bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    debugPrint("createNetUrlFromBytes: $url");
    videoUrl = url;
  }

  Future<void> disposeVideoActivity() async {
    await videoPlayerController.dispose();
    _customVideoPlayerController.dispose();
  }

  @override
  void dispose() {
    disposeVideoActivity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (videoUrl.isNotEmpty == true)
        ? CustomVideoPlayer(customVideoPlayerController: _customVideoPlayerController)
        : const EmptyView();
  }
}
