import 'package:AppDrop/core/models/component_model.dart';
import 'package:flutter/material.dart';

import '../../components/banner_widget.dart';
import '../../components/carousel_widget.dart';
import '../../components/grid_widget.dart';
import '../../components/video_widget.dart';
import '../../components/text_widget.dart';

class WidgetFactory {
  static Widget buildComponent(ComponentModel model) {
    switch (model.type) {
      case "carousel":
        return CarouselWidget(model.props);
      case "grid":
        return GridWidget(model.props);
      case "banner":
        return BannerWidget(model.props);
      case "video":
        return VideoWidget(model.props);
      case "text":
        return TextBlockWidget(model.props);
      default:
        return SizedBox.shrink();
    }
  }
}
