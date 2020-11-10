import 'package:education_app/database/DatabaseVideo.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

class VideoApp extends StatefulWidget {
  final DatabaseVideoList video;

  const VideoApp({Key key, @required this.video}) : super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  var width = 0.0;

  @override
  void initState() {
    super.initState();
    print(widget.video.url.toString());
    _controller = VideoPlayerController.network(
      'https://vimeo.com/469197600',
    );
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey[200],
      ),
      autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
        SliverFillRemainingBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 24.0),
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  'Video Title Here',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Varela_Round',
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
                child: Text(
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using , making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey[200],
                thickness: 16.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
                child: Text(
                  'Next Video',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Varela_Round',
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Card(
                color: Colors.indigo[50],
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: 200.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/images/video1.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Video Title Here',
                        style: TextStyle(
                          fontFamily: 'Varela_Round',
                          fontSize: 16.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[200],
                thickness: 16.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
                child: Text(
                  'More Videos',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Varela_Round',
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return InkWell(
              child: Card(
                color: Colors.indigo[50],
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/images/video1.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Video Title Here',
                        style: TextStyle(
                          fontFamily: 'Varela_Round',
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }, childCount: 10),
        )
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key key, this.controller, this.chewieController})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;
  final ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        //     Align(
        //       alignment: Alignment.topRight,
        //       child: PopupMenuButton<double>(
        //         initialValue: controller.value.playbackSpeed,
        //     tooltip: 'Playback speed',
        //     onSelected: (speed) {
        //       controller.setPlaybackSpeed(speed);
        //     },
        //     itemBuilder: (context) {
        //       return [
        //         for (final speed in _examplePlaybackRates)
        //           PopupMenuItem(
        //             value: speed,
        //             child: Text('${speed}x'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.playbackSpeed}x'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
