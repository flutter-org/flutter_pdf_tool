import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  static Future<String?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: '请选择一个pdf文件',
      allowedExtensions: ['pdf'],
    );
    String? path = result?.files.single.path;
    return path;
  }
}
