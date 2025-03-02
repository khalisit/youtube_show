# Youtube Player KRD 🎬

A powerful and fully customizable **YouTube Player** package for Flutter, allowing seamless integration of YouTube videos with full control over playback options.

## 🚀 Features

- 📺 **Embed YouTube videos** easily with customizable options.
- 🔄 **Supports fullscreen mode.**
- 🎨 **Control visibility of UI controls.**
- 🔊 **Auto-play, mute, looping support.**
- 🛠️ **Pause video when navigating away.**
- 📱 **Works on Android, iOS, and Web.**

## 📦 Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  youtube_player_krd: latest_version
```

Then run:

```sh
flutter pub get
```

## 🎯 Usage

Import the package:

```dart
import 'package:youtube_player_krd/youtube_player_krd.dart';
```

### **Basic Example**

```dart
import 'package:flutter/material.dart';
import 'package:youtube_player_krd/youtube_player_krd.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: YoutubePlayerKrd(),
    );
  }
}

class YoutubePlayerKrd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("YouTube Player KRD")),
      body: Center(
        child: YoutubePlayerKrd(
          url: "https://youtu.be/DYQ4wReivFI?si=SmHVxI5zDXlzo9tX", // Replace with your YouTube video URL
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
```

## 🎛️ Customization

You can customize player settings:

```dart
YoutubePlayerKrd(
  url: "https://www.youtube.com/watch?v=VIDEO_ID",
  width: 400,
  height: 300,
  autoPlay: false,
  mute: true,
  looping: true,
  showControls: false,
  showFullScreen: true,
  pauseOnNavigate: false,
)
```

## 🎮 Controller Functions

Control the player dynamically:

```dart
not now
```

## 📝 License

This package is open-source under the **MIT License**. See [LICENSE](./LICENSE) for details.

---

🌟 **Like this package? Give it a star on GitHub!** 🚀
