import 'package:apk_analyzer/utils/my_logger.dart';
import 'package:archive/archive.dart';
import 'dart:io';


Future<String> extractFileWithZip(String apkPath, String resourcePath, String outputPath) async {
  if (resourcePath.startsWith('/')) {
    resourcePath = resourcePath.substring(1);
  }
  try {
    var bytes = File(apkPath).readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      if (file.isFile && file.name == resourcePath) {
        var outputFile = File('$outputPath/$resourcePath');
        await outputFile.create(recursive: true);
        await outputFile.writeAsBytes(file.readBytes() as List<int>);
        return outputFile.path;
      }
    }
    myLogger.e('未找到指定资源: $resourcePath');
    return '';
  } catch (e) {
    myLogger.e('解压失败: $e');
    return '';
  }
}