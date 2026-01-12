import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
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

 void getImage(ImageSource Camera) async{
  final xFile= await ImagePicker().pickImage(source: Camera);
  if(xFile!= null){
    EasyLoading.show(status: "Please Wait");
    final Fontrecognizer= TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText= await Fontrecognizer.processImage(InputImage.fromFile(File(xFile.path)));
    EasyLoading.dismiss();
    final templist = <String> [];
    for(var block in RecognizedText.blocks){
      for(var line in block.lines){
        templist.add(line.text);
      }
    }
    print(templist);
  }

 }
}
