# FlutterYouTubePlayer 🎬

A powerful and fully customizable **FlutterYoutubePlayer** package for Flutter, allowing seamless integration of YouTube videos in your Flutter apps.

## 🚀 Features

- 📺 **Embed YouTube videos** easily
- 🔄 **Supports fullscreen mode**
- 🎨 **Customizable UI controls**
- 📡 **Supports live streaming**
- 🔧 **Play, pause, seek, and control playback speed**
- 📱 **Works on Android, iOS, and Web**

## 📦 Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  youtube_player: latest_version
```

Then run:

```sh
flutter pub get
```

## 🎯 Usage

Import the package:

```dart
import 'package:youtube_player/youtube_player.dart';
```

### **Basic Example**

```dart
import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: YoutubePlayer(),
    );
  }
}

class YoutubePlayer extends StatefulWidget {
  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter YouTube Player")),
      body: Center(child:
       FlutterYoutubePlayer(
            url: 'url of youtube',
            width: 360.0,
            height: 203.0,
            showControls: true,
            showFullScreen: true,

        ),
      ),
    );
  }
}
```

## 🎛️ Customization

You can customize Youtube Player settings using`:

```dart
FlutterYoutubePlayer(
autoPlay: false,
looping: true,
mute: false,
showControls: true,
showFullScreen: true,
strictRelatedVideos: true,
),
```

## 🛠️ Available Methods

Control the player dynamically:

```dart
not now the future function
```

## 📝 License

This package is open-source under the **MIT License**. See [LICENSE](./license) for details.

---

🌟 **Like this package? Give it a star on GitHub!** 🚀
