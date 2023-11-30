import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class audioApp extends StatefulWidget {


  @override
  State<audioApp> createState() => _audioAppState();
}

class _audioAppState extends State<audioApp> {
  CarouselController controller = CarouselController();
  double _sliderValue = 0.0;
  bool play = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = true;

  @override
  void initState() {
    // TODO: implement initState
    assetsAudioPlayer.open(Audio(Songs[0]),autoStart: false);
    // for(int i=0; i<Songs.length; i++){
    //   ControllerList[i].open(Audio(Songs[i]),autoStart: false);
    //
    // }
    super.initState();
  }


  void seekToSecond(int second){
   setState(() {
     Duration newDuration = Duration(seconds: second);
     assetsAudioPlayer.seek(newDuration);
   });

  }

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  List<AssetsAudioPlayer> ControllerList = [
    AssetsAudioPlayer(),
    AssetsAudioPlayer(),
    AssetsAudioPlayer(),
    AssetsAudioPlayer(),
  ];

  List<String> Songs = [
    'Assets/Chal-Tere-Ishq-Mein-Pad-Jaate-Hain(PagalWorldl) (1).mp3',
    'Assets/Kesariya(PagalWorld.com.pe).mp3',
    'Assets/Tere Vaaste(PagalWorld.com.pe).mp3',
    'Assets/Tum Kya Mile(PagalWorld.com.pe).mp3'
  ];
  final List<String> imagePath = [
    'image/image1.png',
    'image/image2.png',
    'image/image3.png',
    'image/image4.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body:  Column(
        children: [

          CarouselSlider(
            carouselController: controller,
            items: [
              for (int i = 0; i < Songs.length; i++) ...[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: Image.network('https://c.saavncdn.com/026/Chaleya-From-Jawan-Hindi-2023-20230814014337-500x500.jpg'),
                      ),
                      Slider(
                        value: _sliderValue,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (double value) {
                          setState(() {
                            _sliderValue = value;
                            final currentPosition = ControllerList[i].currentPosition.valueOrNull ?? Duration.zero;
                            final totalDuration = ControllerList[i].current.value?.audio?.duration ?? Duration.zero;

                            if (totalDuration != null) {
                              final newTime = totalDuration * value;
                              ControllerList[i].seek(newTime);
                            }
                          });
                        },
                      ),
                      Text(
                        '${(ControllerList[i].currentPosition.hasValue ? ControllerList[i].currentPosition.value : Duration.zero).toString().split('.').first ?? '0:00'} / '
                            '${(ControllerList[i].current.hasValue ? ControllerList[i].current.value?.audio?.duration : Duration.zero).toString().split('.').first ?? '0:00'}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.fast_rewind,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  setState(() {
                                    final currentPosition = ControllerList[i]
                                        .currentPosition
                                        .valueOrNull ??
                                        Duration.zero;
                                    final newPosition =
                                        currentPosition - Duration(seconds: 10);
                                    if (newPosition.isNegative) {
                                      ControllerList[i]
                                          .seek(Duration(seconds: 0));
                                    } else {
                                      ControllerList[i].seek(newPosition);
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  play ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    play = !play;
                                    play
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
                                    final currentPosition = ControllerList[i]
                                        .currentPosition
                                        .valueOrNull ??
                                        Duration.zero;
                                    final newPosition =
                                        currentPosition + Duration(seconds: 10);

                                    final totalDuration = ControllerList[i]
                                        .current
                                        .value
                                        ?.audio
                                        ?.duration;

                                    if (totalDuration != null) {
                                      if (newPosition > totalDuration) {
                                        ControllerList[i].seek(totalDuration);
                                      } else {
                                        ControllerList[i].seek(newPosition);
                                      }
                                    }
                                  });
                                },
                              )
                            ]),
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
              autoPlay: false,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                for(int i=0; i<Songs.length; i++){
                  //ControllerList[i].stop();
                  ControllerList[i].open(Audio(Songs[i]),autoStart: false);

                }
              },
              scrollDirection:
              Axis.horizontal,

            ),
          ),
        ],
      ),
    );
  }
}
