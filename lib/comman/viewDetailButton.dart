import 'package:flutter/material.dart';

class ViewDetailButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;
  final String label;

  const ViewDetailButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.85),
        foregroundColor: Colors.black87,
        shadowColor: Colors.black26,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
