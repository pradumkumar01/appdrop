import 'package:AppDrop/components/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BannerWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const BannerWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final padding = (data['padding'] as num?)?.toDouble() ?? 12;
    final radius = (data['radius'] as num?)?.toDouble() ?? 16;
    final height = (data['height'] as num?)?.toDouble() ?? 180;
    final image = data['image'] as String?;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          NameWidget("Banner Section"),

          // Banner Card
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Stack(
                children: [
                  // Background Image
                  CachedNetworkImage(
                    imageUrl: image ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    fadeInDuration: Duration(milliseconds: 400),
                    placeholder: (_, __) => Container(
                      width: double.infinity,
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey.shade300, Colors.grey.shade200],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey.shade300,
                      child: Icon(Icons.broken_image, size: 40),
                    ),
                  ),

                  // Subtle Gradient Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.25),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Optional tap ripple effect
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {}, // You can add callback
                        splashColor: Colors.white.withValues(alpha: .2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
