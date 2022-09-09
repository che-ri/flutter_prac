import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    videoPlayerController = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');
    await Future.wait([videoPlayerController!.initialize()]).then((value) => {
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController!,
            autoPlay: true, //자동재생
            looping: true, //반복재생
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: chewieController != null &&
                chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(
                controller: chewieController!,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading'),
                ],
              ),
      ),
    );
  }
}
