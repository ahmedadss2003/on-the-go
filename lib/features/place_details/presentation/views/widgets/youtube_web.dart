// // lib/core/widgets/youtube_video_web.dart
// import 'dart:html' as html;
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';

// Widget buildYoutubePlayer(String videoId) {
//   final String viewID = 'youtube-iframe-$videoId';

//   // ignore: undefined_prefixed_name
//   ui.platformViewRegistry.registerViewFactory(
//     viewID,
//     (int _) =>
//         html.IFrameElement()
//           ..width = '100%'
//           ..height = '100%'
//           ..src = 'https://www.youtube.com/embed/$videoId?rel=0'
//           ..style.border = 'none'
//           ..allowFullscreen = true,
//   );

//   return SizedBox(
//     width: double.infinity,
//     height: 300,
//     child: HtmlElementView(viewType: viewID),
//   );
// }
