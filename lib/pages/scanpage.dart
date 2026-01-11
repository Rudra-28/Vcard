import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: const Text("Camera"),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: Icon(Icons.photo_album),
                label: const Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async{
    final xfile = await ImagePicker().pickImage(source: camera);
    if (xfile != null) {
      print(xfile.path);
    }
  }
}
