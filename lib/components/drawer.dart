import 'package:AppDrop/core/models/page_model.dart';
import 'package:AppDrop/main.dart';
import 'package:flutter/material.dart';

final page = PageModel.fromJson(jsonData);

List<Map<String, dynamic>> items = [
  {"icon": Icons.person, "title": "Profile", "screen": ""},
  {"icon": Icons.build_circle_outlined, "title": "Services", "screen": ""},
  {"icon": Icons.info_outline, "title": "About Us", "screen": ""},
  {
    "icon": Icons.shield_moon_outlined,
    "title": "Privacy & Policy",
    "screen": "",
  },
];

Widget drawer() {
  return Container(
    margin: const EdgeInsets.only(top: 50),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Center(
          child: CircleAvatar(
            maxRadius: 50,
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
        const SizedBox(height: 10),
        const Text("Hello", style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        const Divider(thickness: 1),

        // FIX: Add Expanded to ListView
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  items[index]["icon"],
                  color: Colors.blueAccent[700],
                ),
                title: Text(
                  items[index]["title"],
                  style: TextStyle(color: Colors.blueAccent[700], fontSize: 16),
                ),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => items[index]["screen"]),
                  // );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
