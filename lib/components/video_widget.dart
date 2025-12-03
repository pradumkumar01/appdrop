// lib/components/video_widget.dart
import 'package:AppDrop/components/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final Map<String, dynamic> data;

  const VideoWidget(this.data, {super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _hasError = false;
  bool _isBuffering = false;

  String? get _url => (widget.data['url'] as String?)?.trim();

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    final url = _url;
    if (url == null || url.isEmpty) {
      setState(() => _hasError = true);
      return;
    }

    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(url))
        ..addListener(_videoListener)
        ..setLooping(widget.data['loop'] == true);

      await _controller!.initialize();
      if (!mounted) return;

      if (widget.data['autoPlay'] == true) {
        await _controller!.play();
      }

      setState(() {
        _initialized = true;
        _hasError = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _initialized = false;
        });
      }
    }
  }

  void _videoListener() {
    if (!mounted || _controller == null) return;
    final isBuffering = _controller!.value.isBuffering;
    if (isBuffering != _isBuffering) {
      setState(() => _isBuffering = isBuffering);
    }

    if (_controller!.value.hasError && !_hasError) {
      setState(() => _hasError = true);
    }
  }

  @override
  void didUpdateWidget(covariant VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.data['url'] as String?)?.trim() != _url) {
      _disposeController();
      _initialized = false;
      _hasError = false;
      _initializeController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = (widget.data['padding'] as num?)?.toDouble() ?? 12.0;
    final height = (widget.data['height'] as num?)?.toDouble() ?? 240;
    final placeholder = _buildPlaceholder(height);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        children: [
          NameWidget("Video Section"),
          //  video card
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: _hasError
                ? placeholder
                : _initialized && _controller != null
                ? _buildVideoPlayer(height)
                : Stack(
                    alignment: Alignment.center,
                    children: [placeholder, const CircularProgressIndicator()],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade300, Colors.grey.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.play_circle_outline,
          size: 56,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(double height) {
    final controller = _controller!;

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),

          // Subtle gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black.withOpacity(0.25), Colors.transparent],
                ),
              ),
            ),
          ),

          // Buffer loader
          if (_isBuffering)
            const CircularProgressIndicator()
          else
            AnimatedOpacity(
              opacity: controller.value.isPlaying ? 0.0 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 56,
                  color: Colors.white,
                ),
              ),
            ),

          // Mute button
          Positioned(
            bottom: 12,
            right: 12,
            child: IconButton(
              visualDensity: VisualDensity.compact,
              color: Colors.white,
              icon: Icon(
                controller.value.volume > 0
                    ? Icons.volume_up
                    : Icons.volume_off,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  controller.setVolume(controller.value.volume > 0 ? 0.0 : 1.0);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _togglePlayPause() {
    if (_controller == null) return;
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  void _disposeController() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }
}
