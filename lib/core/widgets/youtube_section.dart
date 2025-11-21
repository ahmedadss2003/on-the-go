import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dart:ui_web' as ui;
import 'dart:html' show IFrameElement;

class YoutubeVideoWidget extends StatefulWidget {
  final String videoId;

  const YoutubeVideoWidget({super.key, required this.videoId});

  @override
  _YoutubeVideoWidgetState createState() => _YoutubeVideoWidgetState();
}

class _YoutubeVideoWidgetState extends State<YoutubeVideoWidget> {
  bool _isIframeLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final String viewID = 'youtube-video-${widget.videoId}';

      if (!_isIframeLoaded) {
        // Show a placeholder with the YouTube thumbnail
        return GestureDetector(
          onTap: () {
            setState(() {
              _isIframeLoaded = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // YouTube thumbnail
              Image.network(
                'https://img.youtube.com/vi/${widget.videoId}/hqdefault.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) => const Center(
                      child: Icon(Icons.error, color: Colors.red, size: 50),
                    ),
              ),
              // Play button overlay
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(16),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ],
          ),
        );
      }

      // Register the iframe only once when needed
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        viewID,
        (int _) =>
            IFrameElement()
              ..width = '100%'
              ..height = '100%'
              ..src = 'https://www.youtube.com/embed/${widget.videoId}?rel=0'
              ..style.border = 'none'
              ..allowFullscreen = true
              ..style.pointerEvents =
                  'auto', // Ensure iframe can be interacted with
      );

      // Wrap HtmlElementView in a container to control size and prevent scroll capture
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.width < 600 ? 200 : 400,
        child: HtmlElementView(viewType: viewID),
      );
    } else {
      // Mobile implementation using youtube_player_flutter
      final YoutubePlayerController controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );

      return YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blue,
        progressColors: const ProgressBarColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
        ),
      );
    }
  }
}
