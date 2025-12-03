import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const CarouselWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final images = (data['images'] as List<dynamic>?)?.cast<String>() ?? [];
    final height = (data['height'] as num?)?.toDouble() ?? 180;
    final autoPlay = data['autoPlay'] == true;
    final padding = (data['padding'] as num?)?.toDouble() ?? 0;

    if (images.isEmpty) return SizedBox.shrink();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: padding,
            horizontal: padding / 2,
          ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIdx) {
                final url = images[index];
                return ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (_, __) => Container(color: Colors.grey[200]),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: height,
                autoPlay: autoPlay,
                viewportFraction: 0.95,
                enlargeCenterPage: true,
              ),
            ),
          ),
        ),
        Divider(thickness: 1, height: 1),
      ],
    );
  }
}
