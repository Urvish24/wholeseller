import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_share/flutter_share.dart';

class PdfViewer extends StatefulWidget {
  String filepath = "";


  PdfViewer(this.filepath);

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {


  Future<void> shareFile() async {

    await FlutterShare.shareFile(
      title: 'My Fitness',
      text: 'Documents',
      filePath: widget.filepath,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBarr = AppBar(
      title: Text("PDFView",
          style: TextStyle(color: appSecondColor, fontWeight: FontWeight.w800)),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 20,
          height: 20,
          child: appIcon(iconData: Icons.arrow_back),
        ),
      ),
    );
    return Scaffold(
      appBar: _appBarr,
      body: Container(
        child: Stack(
          children: [
            PDFView(
              filePath: widget.filepath,
            ),
          Positioned(
              bottom: 20,right: 0,left: 0,
              child: RisedButtonuv(title: "Share",onTap: ()=>shareFile())),

      ],
        ),
      ),
    );
  }
}
