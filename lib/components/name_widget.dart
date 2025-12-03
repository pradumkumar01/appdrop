import 'package:flutter/material.dart';

class NameWidget extends StatelessWidget {
  final title;
  const NameWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.blue[900],
          ),
        ),
      ),
    );
  }
}
