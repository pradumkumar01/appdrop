import 'package:AppDrop/screens/splash.dart';
import 'package:flutter/material.dart';
import 'core/models/page_model.dart';

final jsonData = {
  "page": {
    "components": [
      {
        "name": "Carousel Section",
        "type": "carousel",
        "images": [
          "https://picsum.photos/800/300?1",
          "https://picsum.photos/800/300?2",
          "https://picsum.photos/800/300?3",
        ],
        "height": 200,
        "autoPlay": true,
        "padding": 12,
        "spacing": 8,
      },
      {
        "name": "Images Section",
        "type": "grid",
        "images": [
          "https://picsum.photos/200/200?1",
          "https://picsum.photos/200/200?2",
          "https://picsum.photos/200/200?3",
          "https://picsum.photos/200/200?4",
        ],
        "columns": 2,
        "spacing": 8,
        "padding": 16,
      },
      {
        "name": "Banner Section",
        "type": "banner",
        "image": "https://picsum.photos/800/300",
        "height": 180,
        "padding": 16,
        "radius": 12,
      },
      {
        "name": "Video Section",
        "type": "video",
        "url":
            "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "autoPlay": false,
        "loop": false,
        "height": 220,
        "padding": 12,
      },

      {
        "name": "",
        "type": "text",
        "value": "All c@pyrights are reserved to AppDrop",
        "size": 18,
        "weight": "bold",
        "align": "center",
        "padding": 16,
      },
    ],
  },
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final page = PageModel.fromJson(jsonData);
  runApp(MyApp(page));
}

class MyApp extends StatelessWidget {
  final PageModel page;

  const MyApp(this.page, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(page),
    );
  }
}
