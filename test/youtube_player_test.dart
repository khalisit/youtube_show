import 'package:flutter/material.dart';
import 'package:youtube_show/youtube_show.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: YoutubeShowpage());
  }
}

class YoutubeShowpage extends StatelessWidget {
  const YoutubeShowpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("YouTube Player KRD")),
      body: Center(
        child: YoutubeShow(
          url:
              "https://youtu.be/rC4n6H7AkpY?si=PG10oqcFnVbslvrM", // Replace with your YouTube video URL
          width: 300,
          height: 200,
          autoPlay: true,
          mute: false,
          looping: false,
          showControls: true,
          showFullScreen: true,
          pauseOnNavigate: true,
        ),
      ),
    );
  }
}
