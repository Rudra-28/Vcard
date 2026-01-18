import 'dart:io';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
  static const String routeName = 'scanpage';

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanOver = false;
  List<String> lines = [];
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
          Wrap(children: lines.map((e) => LineItem(line: e)).toList()),
        ],
      ),
    );
  }

  void getImage(ImageSource Camera) async {
    final xFile = await ImagePicker().pickImage(source: Camera);
    if (xFile != null) {
      EasyLoading.show(status: "Please Wait");
      final Textrecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final RecognizedText = await Textrecognizer.processImage(
        InputImage.fromFile(File(xFile.path)),
      );
      EasyLoading.dismiss();
      final templist = <String>[];
      for (var block in RecognizedText.blocks) {
        for (var line in block.lines) {
          templist.add(line.text);
        }
      }
      setState(() {
        lines = templist;
        isScanOver = true;
      });
    }
  }
}

class LineItem extends StatefulWidget {
  const LineItem({super.key, required this.line});
  final String line;
  @override
  State<LineItem> createState() => _LineItemState();
}

class _LineItemState extends State<LineItem> {
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: widget.line,
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: Container(
        key: GlobalKey(),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.black45),
        child: Text(
          widget.line,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
      child: Chip(label: Text(widget.line)),
    );
  }
}

class DropTargetItem extends StatefulWidget {
  const DropTargetItem({
    super.key,
    required this.property,
    required this.onDrop,
  });
  final String property;
  final Function(String, String) onDrop;
  @override
  State<DropTargetItem> createState() => _DropTargetItemState();
}

class _DropTargetItemState extends State<DropTargetItem> {
  @override
  String dragItem = '';
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(widget.property)),
        Expanded(
          flex: 2,
          child: DragTarget<String>(
            builder: (context, candidateData, rejectData) => Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: candidateData.isNotEmpty
                    ? Border.all(color: Colors.red, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(child: Text(
                    dragItem.isNotEmpty?'Drop Here':dragItem
                  )),
                  InkWell(
                    onTap: (){
                      setState(() {
                        dragItem='';
                      });
                    },
                    child: const Icon(Icons.clear),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
