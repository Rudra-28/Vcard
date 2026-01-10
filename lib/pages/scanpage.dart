import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});
  static const String routeName = 'scanpage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan your Visiting Card")),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.camera),
                label: const Text("Camera"),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.photo_album),
                label: const Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
