// any time update use flutter pub publish

library;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
const kYoutubeAspectRatio = 16 / 9;
final _youtubeFullScreenControllerMap = <String, YoutubePlayerController>{};

class YoutubeShow extends StatefulWidget {
  const YoutubeShow({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.autoPlay = false,
    this.mute = false,
    this.looping = false,
    this.showControls = true,
    this.showFullScreen = false,
    this.pauseOnNavigate = true,
    this.strictRelatedVideos = false,
  });

  final String url;
  final double? width;
  final double? height;
  final bool autoPlay;
  final bool mute;
  final bool looping;
  final bool showControls;
  final bool showFullScreen;
  final bool pauseOnNavigate;
  final bool strictRelatedVideos;

  @override
  State<YoutubeShow> createState() => _YoutubeShowState();
}

class _YoutubeShowState extends State<YoutubeShow> with RouteAware {
  YoutubePlayerController? _controller;
  String? _videoId;
  _YoutubeFullScreenWrapperState? _youtubeWrapper;
  bool _subscribedRoute = false;

  bool get handleFullScreen =>
      !kIsWeb && widget.showFullScreen && _youtubeWrapper != null;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    if (!handleFullScreen || _youtubeWrapper?._controller == null) {
      if (_subscribedRoute) {
        routeObserver.unsubscribe(this);
      }
      _controller?.close();
      _youtubeFullScreenControllerMap[_videoId]?.close();
      _youtubeFullScreenControllerMap.remove(_videoId);
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
      _subscribedRoute = true;
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    }
  }

  @override
  void didPushNext() {
    if (widget.pauseOnNavigate) {
      _controller?.pauseVideo();
    }
  }

  double get width =>
      widget.width == null || widget.width! >= double.infinity
          ? MediaQuery.sizeOf(context).width
          : widget.width!;

  double get height =>
      widget.height == null || widget.height! >= double.infinity
          ? width / kYoutubeAspectRatio
          : widget.height!;

  void initializePlayer() {
    if (!mounted) {
      return;
    }
    final videoId = _convertUrlToId(widget.url);
    if (videoId == null) {
      return;
    }
    _videoId = videoId;
    _youtubeWrapper = YoutubeFullScreenWrapper.of(context);

    if (handleFullScreen &&
        _youtubeFullScreenControllerMap.containsKey(_videoId)) {
      _controller = _youtubeFullScreenControllerMap[_videoId]!;
      _youtubeFullScreenControllerMap.clear();
    } else {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: widget.autoPlay,
        params: YoutubePlayerParams(
          mute: widget.mute,
          loop: widget.looping,
          showControls: widget.showControls,
          showFullscreenButton: widget.showFullScreen,
          strictRelatedVideos: widget.strictRelatedVideos,
        ),
      );
    }
    if (handleFullScreen) {
      _controller!.setFullScreenListener((fullScreen) {
        if (fullScreen) {
          _youtubeFullScreenControllerMap[_videoId!] = _controller!;
          _youtubeWrapper!.updateYoutubePlayer(_controller, _videoId);
        } else {
          _youtubeWrapper!.updateYoutubePlayer();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => FittedBox(
    fit: BoxFit.cover,
    child: SizedBox(
      height: height,
      width: width,
      child:
          _controller != null
              ? handleFullScreen
                  ? YoutubePlayerScaffold(
                    controller: _controller!,
                    builder: (_, player) => player,
                    autoFullScreen: false,
                    gestureRecognizers: const <Factory<TapGestureRecognizer>>{},
                    enableFullScreenOnVerticalDrag: false,
                  )
                  : YoutubePlayer(
                    controller: _controller!,
                    gestureRecognizers: const <Factory<TapGestureRecognizer>>{},
                    enableFullScreenOnVerticalDrag: false,
                  )
              : Container(color: Colors.transparent),
    ),
  );
}

/// Wraps the page in order to properly show the YouTube video when fullscreen.
class YoutubeFullScreenWrapper extends StatefulWidget {
  const YoutubeFullScreenWrapper({super.key, required this.child});

  final Widget child;

  // ignore: library_private_types_in_public_api
  static _YoutubeFullScreenWrapperState? of(BuildContext context) =>
      context.findAncestorStateOfType<_YoutubeFullScreenWrapperState>();

  @override
  State<YoutubeFullScreenWrapper> createState() =>
      _YoutubeFullScreenWrapperState();
}

class _YoutubeFullScreenWrapperState extends State<YoutubeFullScreenWrapper> {
  YoutubePlayerController? _controller;
  String? _videoId;

  void updateYoutubePlayer([
    YoutubePlayerController? controller,
    String? videoId,
  ]) => setState(() {
    _controller = controller;
    _videoId = videoId;
  });

  @override
  void dispose() {
    _controller?.close();
    _youtubeFullScreenControllerMap.remove(_videoId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _controller != null
          ? YoutubePlayerScaffold(
            controller: _controller!,
            builder: (_, player) => player,
            enableFullScreenOnVerticalDrag: false,
          )
          : widget.child;
}

String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
  assert(url.isNotEmpty, 'Url cannot be empty');
  if (!url.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();
  for (final regex in [
    RegExp(
      r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$",
    ),
    RegExp(
      r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$",
    ),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$"),
  ]) {
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }
  return null;
}
