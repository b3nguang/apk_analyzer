import 'dart:io';

import 'package:apk_analyzer/utils/my_logger.dart';

Future<void> initFile(String filePath) async {
  /*
  判断文件是否存在，如果不存在则创建文件
  */
  try {
    // 创建File对象
    final file = File(filePath);

    // 检查文件是否存在
    if (await file.exists()) {
      return;
    }

    // 获取父目录路径
    final directory = file.parent;

    // 如果目录不存在则创建
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // 创建文件
    await file.create();
  } catch (e) {
    myLogger.e('创建文件失败：$e');
  }
}


Future<void> initDirectory(String directoryPath) async {
  /*
  判断目录是否存在，如果不存在则创建目录
  */
  try {
    // 创建Directory对象
    final directory = Directory(directoryPath);

    // 如果目录不存在则创建
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  } catch (e) {
    myLogger.e('创建目录失败：$e');
  }
}

Future<bool> checkFileExists(String filePath) async {
  /*
  检查文件是否存在
  */
  try {
    final file = File(filePath);
    return await file.exists();
  } catch (e) {
    return false;
  }
}

Future<List<File>> getAllFilesRecursive(String dirPath) async {
  Directory dir = Directory(dirPath);
  final List<File> files = [];
  
  try {
    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) {
        files.add(entity);
      }
    }
  } catch (e) {
    myLogger.e('错误: $e');
  }
  
  return files;
}


Future<bool> checkDirectoryExists(String directoryPath) async {
  /*
  检查目录是否存在
  */
  try {
    final directory = Directory(directoryPath);
      return await directory.exists();
  } catch (e) {
    return false;
  }
}
