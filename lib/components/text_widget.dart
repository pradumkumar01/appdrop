import 'package:flutter/material.dart';

class TextBlockWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const TextBlockWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final padding = (data['padding'] as num?)?.toDouble() ?? 0;
    final value = data['value'] as String? ?? '';
    final size = (data['size'] as num?)?.toDouble() ?? 14;
    final weight = (data['weight'] as String?) ?? 'normal';
    final align = (data['align'] as String?) ?? 'left';

    return Column(
      children: [
        Divider(thickness: 1, height: 1),
        Padding(
          padding: EdgeInsets.all(padding / 3),
          child: Text(
            value,
            textAlign: _mapAlign(align),
            style: TextStyle(
              fontSize: size / 1.5,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }

  TextAlign _mapAlign(String align) {
    switch (align.toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  FontWeight _mapWeight(String w) {
    switch (w.toLowerCase()) {
      case 'bold':
        return FontWeight.bold;
      case 'w600':
        return FontWeight.w600;
      case 'w700':
        return FontWeight.w700;
      default:
        return FontWeight.normal;
    }
  }
}
