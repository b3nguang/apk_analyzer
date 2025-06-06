import 'package:apk_analyzer/utils/consts.dart';
import 'package:apk_analyzer/utils/files.dart';
import 'package:logger/logger.dart';
import 'dart:io';


Future<void> initLogFile() async {
  await initFile(logFilePath);
}

Logger _getMyLogger() {
  FileOutput fileOutPut = FileOutput(file: File(logFilePath));
  // ConsoleOutput consoleOutput = ConsoleOutput();
  // List<LogOutput> multiOutput = [fileOutPut, consoleOutput];
  List<LogOutput> multiOutput = [fileOutPut];
  // 开发模式
  // Logger.defaultFilter = () => DevelopmentFilter();
  // 生产模式
  Logger.defaultFilter = () => ProductionFilter();

  Logger myLogger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // Number of method calls to be displayed
      errorMethodCount: 5, // Number of method calls to be displayed for errors
      colors: true, // Enable colors in the log output
      dateTimeFormat:
          DateTimeFormat.dateAndTime, // Print timestamp in the log output
    ),
    output: MultiOutput(multiOutput),
  );
  return myLogger;
}

Logger myLogger = _getMyLogger();