import 'package:apk_analyzer/utils/consts.dart';
import 'package:apk_analyzer/utils/my_logger.dart';
import 'package:process_run/process_run.dart';


Future<String> extractFileWith7z(String apkPath,String resourcePath,String outputPath) async {
  var shell = Shell(verbose: false);
  if (resourcePath.startsWith('/')) {
    resourcePath = resourcePath.substring(1);
  }
  try {
    var command = '${await getZipPath()} $extractApkCommand "$apkPath" "$resourcePath" -o"$outputPath" -y';
    myLogger.i('执行命令: $command');
    var result = await shell.run(command);
    if (result.outText.contains('Everything is Ok')) {
      return '$outputPath/$resourcePath';
    } else {
      myLogger.e('解压失败: ${result.outText}');
      return '';
    }
  } catch (e) {
    myLogger.e('执行命令失败: $e');
    return '';
  }
}