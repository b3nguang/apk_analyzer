import 'dart:io';
import 'package:apk_analyzer/utils/consts.dart';

List<Map<String,dynamic>> getPlugins(){
  String path = easyFridaPluginPath;
  File file = File(path);
  String data = file.readAsStringSync();
  List<Map<String,dynamic>> plugins = [];
  List<String> pluginList = data.split("\n");
  int cnt = 0;
  for(String plugin in pluginList){
    List<String> temp = plugin.split(" ");
    String name = temp.first;
    String message = temp.last;
    plugins.add({
      "id":cnt,
      "title":name,
      "message":message,
      "selected":false,
    });
    cnt += 1;
  }
  return plugins;
}
