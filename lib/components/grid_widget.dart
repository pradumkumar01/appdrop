import 'package:AppDrop/components/name_widget.dart';
import 'package:AppDrop/screens/gallery.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const GridWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final images = (data['images'] as List<dynamic>?)?.cast<String>() ?? [];
    final columns = (data['columns'] as int?) ?? 3;
    final spacing = (data['spacing'] as num?)?.toDouble() ?? 8;
    final padding = (data['padding'] as num?)?.toDouble() ?? 12;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NameWidget("Image Gallery"),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryScreen(data),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Image Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemBuilder: (context, index) {
              return _buildImageCard(images[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Network Image
            CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 400),
              placeholder: (_, __) => Container(color: Colors.grey[200]),
              errorWidget: (_, __, ___) => Container(
                color: Colors.grey[300],
                child: Icon(
                  Icons.broken_image,
                  size: 32,
                  color: Colors.black38,
                ),
              ),
            ),

            // Overlay hover effect
            Positioned.fill(
              child: InkWell(
                splashColor: Colors.black.withValues(alpha: 0.2),
                highlightColor: Colors.black.withValues(alpha: 0.05),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
