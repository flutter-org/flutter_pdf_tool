import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  static Future<String?> pickPDF() async {
    return await _pickFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }

  static Future<String?> pickPNG() async {
    return await _pickFile(
      type: FileType.image,
      allowedExtensions: ['png'],
    );
  }

  static Future<String?> _pickFile({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
    );
    String? path = result?.files.single.path;
    return path;
  }
}
