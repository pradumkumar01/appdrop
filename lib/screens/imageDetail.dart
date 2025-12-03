import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;
  final Map<String, dynamic> data;

  const ImageDetailsScreen(this.item, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final url = item["url"];
    final title = data["name"] ?? "Untitled Image";
    final desc = item["desc"] ?? "No description available";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Details"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF2F3F7),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: url,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      Container(height: 300, color: Colors.grey.shade200),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 10),

            Text(
              desc,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),

            const SizedBox(height: 20),

            _detailsRow("URL", url),
            if (item["uploaded_on"] != null)
              _detailsRow("Uploaded On", item["uploaded_on"]),
            if (item["author"] != null) _detailsRow("Author", item["author"]),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Automatically request storage permission silently
                  PermissionStatus status = await Permission.storage.request();

                  // If user denies, just show message and stop
                  if (!status.isGranted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Storage permission denied"),
                      ),
                    );
                    return;
                  }

                  // Show loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    final dir = await getExternalStorageDirectory();
                    final filePath =
                        '${dir!.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';

                    await Dio().download(url, filePath);

                    Navigator.pop(context); // close loading dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Downloaded to $filePath')),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Download failed: $e')),
                    );
                  }
                },
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text(
                  "Download",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailsRow(String label, String? value) {
    if (value == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(value, style: const TextStyle(fontSize: 15)),
        const SizedBox(height: 12),
      ],
    );
  }
}
