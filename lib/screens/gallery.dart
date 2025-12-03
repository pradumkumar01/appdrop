import 'package:AppDrop/comman/viewDetailButton.dart';
import 'package:AppDrop/screens/imageDetail.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const GalleryScreen(this.data, {super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late List<Map<String, dynamic>> images;

  @override
  void initState() {
    super.initState();

    final list = widget.data["images"];

    if (list is List) {
      images = list.map((e) {
        if (e is String) {
          return {"url": e};
        }
        return Map<String, dynamic>.from(e);
      }).toList();
    } else {
      images = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FF),
      appBar: AppBar(
        title: const Text(
          "Gallery",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black12,
      ),

      body: images.isEmpty
          ? const Center(
              child: Text(
                "No Images Found",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final item = images[index];
                final url = item["url"];

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Hero(
                          tag: url,
                          child: CachedNetworkImage(
                            imageUrl: url,
                            height: 240,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (_, __) =>
                                Container(color: Colors.grey.shade300),
                            errorWidget: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 40),
                          ),
                        ),
                      ),

                      // Gradient Overlay for Professional Look
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(18),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.45),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),

                      // View Details Button (Floating Style)
                      Positioned(
                        bottom: 18,
                        right: 18,
                        child: ViewDetailButton(
                          icon: const Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: "View Details",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ImageDetailsScreen(item, widget.data),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
