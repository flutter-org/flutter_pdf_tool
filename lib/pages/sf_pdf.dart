import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdf_tool/packages/file_picker_util.dart';
import 'package:flutter_pdf_tool/packages/path_provider_util.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SFPDFPage extends StatefulWidget {
  const SFPDFPage({super.key});

  @override
  State<SFPDFPage> createState() => _SFPDFPageState();
}

class _SFPDFPageState extends State<SFPDFPage> {
  File? _pdfFile;
  File? _imageFile;
  double _imageTop = 0;
  double _imageLeft = 0;
  double _imageScale = 1.0;

  PdfDocument? _document;

  Future<void> _onClickPickPDF() async {
    String? path = await FilePickerUtil.pickPDF();
    if (path != null) {
      setState(() {
        _pdfFile = File(path);
      });
    }
  }

  Future<void> _onClickSeal() async {
    String? path = await FilePickerUtil.pickPNG();
    if (path != null) {
      setState(() {
        _imageFile = File(path);
      });
    }
  }

  Future<void> save({
    required File imageFile,
    required Rect rect,
  }) async {
    final PdfDocument document = PdfDocument(inputBytes: _pdfFile!.readAsBytesSync());
    final PdfPage page = document.pages[0];
    final Uint8List imageData = imageFile.readAsBytesSync();
    final PdfBitmap pdfBitmap = PdfBitmap(imageData);
    page.graphics.drawImage(pdfBitmap, rect);
    final List<int> bytes = await document.save();
    String tempPath = await PathProviderUtil.temporaryDirectory();
    File newFile = await File('$tempPath/ImageToPDF.pdf').writeAsBytes(bytes);
    setState(() {
      _pdfFile = newFile;
    });
    document.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_document != null)
            IconButton(
              onPressed: _onClickSeal,
              icon: const Icon(Icons.image),
            ),
        ],
      ),
      body: _pdfFile != null
          ? Stack(
              children: [
                SfPdfViewer.file(
                  _pdfFile!,
                  onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                    setState(() {
                      _document = details.document;
                    });
                  },
                ),
                if (_imageFile != null)
                  Positioned(
                    top: _imageTop,
                    left: _imageLeft,
                    child: GestureDetector(
                      onScaleUpdate: (ScaleUpdateDetails details) {
                        print("onScaleUpdate:${details.scale}");
                      },
                      child: GestureDetector(
                        onPanUpdate: (DragUpdateDetails details) {
                          _imageTop = max(0, _imageTop + details.delta.dy);
                          _imageLeft = max(0, _imageLeft + details.delta.dx);
                          setState(() {});
                        },
                        child: Image.file(
                          _imageFile!,
                          scale: _imageScale,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          : TextButton(
              onPressed: _onClickPickPDF,
              child: const Text('请选择一个pdf文件'),
            ),
    );
  }
}
