import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathProviderUtil {
  /// 这是一个系统可以随时清空的临时（缓存）文件夹。
  static Future<String> temporaryDirectory() async {
    final Directory dir = await getTemporaryDirectory();
    final String path = dir.path;
    print("getTemporaryDirectory path:$path");
    return path;
  }

  /// 供应用使用，用于存储只能由该应用访问的文件。只有在删除应用时，系统才会清除这个目录。
  static Future<String> applicationDocumentsDirectory() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path;
    print("getApplicationDocumentsDirectory path:$path");
    return path;
  }

  static Future<String> applicationCacheDirectory() async {
    final Directory dir = await getApplicationCacheDirectory();
    final String path = dir.path;
    print("getApplicationCacheDirectory path:$path");
    return path;
  }

  static Future<String> applicationSupportDirectory() async {
    final Directory dir = await getApplicationSupportDirectory();
    final String path = dir.path;
    print("getApplicationSupportDirectory path:$path");
    return path;
  }
}
