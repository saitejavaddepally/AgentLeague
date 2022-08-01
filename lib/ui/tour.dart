
import 'package:agent_league/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import '../theme/colors.dart';

class Tour extends StatefulWidget {
  final Map info;

  const Tour({Key? key, required this.info}) : super(key: key);

  @override
  State<Tour> createState() => _TourState();
}

class _TourState extends State<Tour> {
  late List res;

  Future<List> getVideos() async {
    int currentPlot = widget.info['currentPage'];
    List videos = widget.info['plotPagesInformation'][currentPlot][0]['videos'];
    List videoNames =
        widget.info['plotPagesInformation'][currentPlot][0]['videoNames'];

    return [
      {"videos": videos},
      {"videoNames": videoNames}
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SpinKitThreeBounce(
            size: 30,
            color: Colors.white,
          );
        }
        if (snapshot.hasData) {
          res = snapshot.data as List;
        }

        return Scaffold(
            body: SafeArea(
                child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  GestureDetector(
                      onTap: () {}, child: const Icon(Icons.share_outlined))
                ],
              ),
              const SizedBox(height: 30),
              Text(
                  '150 Sq.yards  G+1 House at SaiNagar, LB Nagar for 7000000'
                      .toLowerCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: -0.15,
                      color: Colors.white.withOpacity(0.87))),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Flexible(
                  child: ListView.builder(
                      itemCount: res[0]['videos'].length,
                      itemBuilder: (context, index) {
                        var videoLink = res[0]['videos'][index];

                        return (videoLink != null || videoLink != "null")
                            ? VideoPlayPage(
                                videoLink: videoLink,
                                videoName: res[1]['videoNames'][index])
                            : const SizedBox();
                      }))
            ],
          ),
        )));
      },
    );
  }
}

class VideoPlayPage extends StatefulWidget {
  final String videoLink;
  final String videoName;

  const VideoPlayPage(
      {required this.videoLink, required this.videoName, Key? key})
      : super(key: key);

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoLink);
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: shadow2,
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: Stack(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // If the video is playing, pause it.
                          if (_controller.value.isPlaying) {
                            setState(() {
                              _controller.pause();
                            });
                          }
                        },
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: VideoPlayer(_controller)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(widget.videoName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: HexColor('1B1B1B'),
                                    letterSpacing: -0.15)),
                          ),
                          Image.asset('assets/download.png'),
                          const SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {},
                              child: Image.asset('assets/share.png')),
                          const SizedBox(width: 10)
                        ],
                      )
                    ],
                  ),
                  if (!_controller.value.isPlaying)
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _controller.play();
                                });
                              },
                              child: Image.asset("assets/play.png"))),
                    ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
