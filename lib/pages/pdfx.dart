import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdf_tool/packages/file_picker_util.dart';
import 'package:pdfx/pdfx.dart';

class PDFXPage extends StatefulWidget {
  const PDFXPage({super.key});

  @override
  State<PDFXPage> createState() => _PDFXPageState();
}

class _PDFXPageState extends State<PDFXPage> {
  PdfControllerPinch? _pdfControllerPinch;

  Future<void> _onClickPickPDF() async {
    String? path = await FilePickerUtil.pickPDF();
    if (path != null) {
      setState(() {
        _pdfControllerPinch = PdfControllerPinch(
          document: PdfDocument.openFile(path),
        );
      });
    }
  }

  @override
  void dispose() {
    _pdfControllerPinch?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pdfControllerPinch != null
          ? PdfViewPinch(
              controller: _pdfControllerPinch!,
            )
          : TextButton(
              onPressed: _onClickPickPDF,
              child: const Text('请选择一个pdf文件'),
            ),
    );
  }
}
