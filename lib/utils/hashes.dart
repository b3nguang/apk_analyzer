import 'dart:io';
import 'package:apk_analyzer/utils/files.dart';
import 'package:apk_analyzer/utils/my_logger.dart';
import 'package:crypto/crypto.dart';



Future<String> getFileSHA256(String filePath) async {
  if (!await checkFileExists(filePath)) {
    myLogger.e('文件不存在: $filePath');
    return "";
  }
  try{
myLogger.i("计算文件哈希值：$filePath");
  // 读取文件内容
  var bytes = await File(filePath).readAsBytes();

  // 计算 SHA-256 哈希值
  var hexString = sha256.convert(bytes);
  myLogger.d("SHA256值：${hexString.toString()}");
  // 输出哈希值（以十六进制字符串形式）
  return hexString.toString();
  }catch(e){
    myLogger.e("计算哈希值出现问题：$e");
  }
  return '';
}
