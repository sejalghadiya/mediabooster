import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  @override
  State<VideoApp> createState() => _VideoAppState();
}

class VideoItem {
  final String videoUrl;
  VideoItem(this.videoUrl);
}

class _VideoAppState extends State<VideoApp> {
  final List<String> videos = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4'
  ];
  List<VideoPlayerController> ControllerList = [
    VideoPlayerController.networkUrl(
      Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'),
    ),
    VideoPlayerController.networkUrl(
      Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',)
    ),
    VideoPlayerController.networkUrl(
      Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',)
    ),
    VideoPlayerController.networkUrl(
      Uri.parse('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',)
    ),
    VideoPlayerController.networkUrl(
      Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4')
    )
  ];
  CarouselController Controller = CarouselController();
  double _sliderValue = 0.0;
  void initState() {
    super.initState();
    for (int i = 0; i < videos.length; i++) {
      ControllerList[i] = VideoPlayerController.networkUrl(Uri.parse(videos[i]))
        ..initialize().then((_) {
         // setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            height: double.infinity,
            child: CarouselSlider(
              carouselController: Controller,
              items: [
                for (int i = 0; i < videos.length; i++) ...[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ControllerList[i].value.isInitialized
                            ? AspectRatio(
                          aspectRatio:
                          ControllerList[i].value.aspectRatio,
                          child: VideoPlayer(ControllerList[i]),
                        )
                            : CircularProgressIndicator(),
                        Slider(
                          value: _sliderValue,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (double value) {
                            setState(() {
                              _sliderValue = value;
                              final newTime =
                                  ControllerList[i].value.duration * value;
                              ControllerList[i].seekTo(newTime);
                            });
                          },
                        ),
                        Text(
                          '${(ControllerList[i].value.position).toString().split('.').first} / ${(ControllerList[i].value.duration).toString().split('.').first}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.fast_rewind, color: Colors.white, size: 30),
                                onPressed: () {
                                  setState(() {
                                    final currentPosition = ControllerList[i].value.position;
                                    final newPosition = currentPosition - Duration(seconds: 10);
                                    if (newPosition.isNegative) {
                                      ControllerList[i].seekTo(Duration(seconds: 0));
                                    } else {
                                      ControllerList[i].seekTo(newPosition);
                                    }
                                  });
                                },
                              ),

                              IconButton(
                                icon: Icon(
                                  ControllerList[i].value.isPlaying
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    ControllerList[i].value.isPlaying
                                        ? ControllerList[i].pause()
                                        : ControllerList[i].play();
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.fast_forward,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  setState(() {
                                    final currentPosition =
                                        ControllerList[i].value.position;
                                    final newPosition =
                                        currentPosition + Duration(seconds: 10);
                                    if (newPosition >
                                        ControllerList[i].value.duration) {
                                      ControllerList[i].seekTo(
                                          ControllerList[i].value.duration);
                                    } else {
                                      ControllerList[i].seekTo(newPosition);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ],
              options: CarouselOptions(
                height: 300,
                aspectRatio: 19 / 2,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlayAnimationDuration:
                Duration(milliseconds: 800),
                autoPlayCurve:
                Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  return videos;
                },
                scrollDirection: Axis
                    .horizontal,
              ),
            ),
          )),
    );
  }
}